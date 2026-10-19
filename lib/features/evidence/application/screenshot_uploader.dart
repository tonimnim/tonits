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
    final mediaType = mediaTypeOf(bytes);
    if (mediaType == null) {
      throw ScreenshotProblem(_l.matchScreenshotWrongType);
    }
    if (bytes.length > maxBytes) {
      throw ScreenshotProblem(_l.matchScreenshotTooLarge);
    }

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
