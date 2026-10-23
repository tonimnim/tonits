import 'dart:typed_data';

import 'package:crypto/crypto.dart';

import '../../../core/l10n.dart';
import '../data/evidence_repository.dart';

enum UploadStage { uploading, verifying }

/// Why a screenshot couldn't be used, in the player's terms.
class ScreenshotProblem implements Exception {
  const ScreenshotProblem(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Turns a picked image into a verified screenshot the match can use:
/// declare it, upload the original bytes, then wait for verification.
/// The bytes are never recompressed: the reader needs the original.
class ScreenshotUploader {
  ScreenshotUploader(this._repository, this._delay, this._l);

  final EvidenceRepository _repository;
  final Duration Function(int attempt) _delay;

  /// The player-facing text for [ScreenshotProblem]s.
  final AppLocalizations _l;

  static const maxBytes = 10 * 1024 * 1024;

  /// About two minutes of checks before giving up.
  static const _maxChecks = 20;

  /// Returns the verified evidence ID.
  Future<String> upload(
    Uint8List bytes, {
    void Function(UploadStage stage)? onStage,
  }) async {
    final problem = problemWith(bytes, _l);
    if (problem != null) throw ScreenshotProblem(problem);
    final mediaType = mediaTypeOf(bytes)!;

    onStage?.call(UploadStage.uploading);
    final intent = await _repository.createUpload(
      mediaType: mediaType,
      byteSize: bytes.length,
      sha256: sha256.convert(bytes).toString(),
    );
    if (!await _repository.upload(intent, bytes)) {
      throw ScreenshotProblem(_l.matchScreenshotUploadFailed);
    }

    onStage?.call(UploadStage.verifying);
    var evidence = await _repository.complete(intent.id);
    for (var attempt = 0; !evidence.ready; attempt++) {
      if (evidence.failed) {
        throw ScreenshotProblem(_l.matchScreenshotUnusable);
      }
      if (attempt >= _maxChecks) {
        throw ScreenshotProblem(_l.matchScreenshotSlow);
      }
      await Future<void>.delayed(_delay(attempt));
      evidence = await _repository.status(intent.id);
    }
    return evidence.id;
  }

  /// Why [bytes] can't be sent as a screenshot, before anything is
  /// uploaded, or null when they can.
  static String? problemWith(Uint8List bytes, AppLocalizations l) {
    // An iPhone camera photo, likely of another screen.
    if (isCameraPhoto(bytes)) return l.matchScreenshotIsPhoto;
    if (mediaTypeOf(bytes) == null) return l.matchScreenshotWrongType;
    if (bytes.length > maxBytes) return l.matchScreenshotTooLarge;
    return null;
  }

  /// HEIC or AVIF: how iPhones save camera photos. Screenshots are PNG.
  static bool isCameraPhoto(Uint8List bytes) {
    if (bytes.length < 12) return false;
    final box = String.fromCharCodes(bytes.sublist(4, 8));
    final brand = String.fromCharCodes(bytes.sublist(8, 12));
    return box == 'ftyp' &&
        const {
          'heic',
          'heix',
          'heim',
          'heis',
          'hevc',
          'hevx',
          'mif1',
          'msf1',
          'avif',
          'avis',
        }.contains(brand);
  }

  /// `image/jpeg` or `image/png` from the file's first bytes, or null.
  static String? mediaTypeOf(Uint8List bytes) {
    bool startsWith(List<int> magic) =>
        bytes.length >= magic.length &&
        Iterable<int>.generate(magic.length).every((i) => bytes[i] == magic[i]);
    if (startsWith(const [0xFF, 0xD8, 0xFF])) return 'image/jpeg';
    if (startsWith(const [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A])) {
      return 'image/png';
    }
    return null;
  }
}
