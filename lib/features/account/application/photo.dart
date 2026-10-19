import 'dart:typed_data';

import '../../evidence/application/screenshot_uploader.dart';

/// Why a photo couldn't be used, in the player's terms.
class PhotoProblem implements Exception {
  const PhotoProblem(this.message);

  final String message;

  @override
  String toString() => message;
}

/// The largest profile photo the API takes.
const maxPhotoBytes = 10 * 1024 * 1024;

/// `image/jpeg`, `image/png` or `image/webp` from a photo's first bytes,
/// or null.
String? photoTypeOf(Uint8List bytes) {
  final type = ScreenshotUploader.mediaTypeOf(bytes);
  if (type != null) return type;
  bool at(int offset, String ascii) =>
      bytes.length >= offset + ascii.length &&
      ascii.codeUnits.indexed.every((c) => bytes[offset + c.$1] == c.$2);
  return at(0, 'RIFF') && at(8, 'WEBP') ? 'image/webp' : null;
}
