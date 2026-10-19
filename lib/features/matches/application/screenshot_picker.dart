import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// Lets the player choose a screenshot from their photos and returns its
/// original bytes, or null when they cancel. Tests supply their own.
final screenshotPickerProvider = Provider<Future<Uint8List?> Function()>(
  (ref) => () async {
    // No resizing or quality options: those would re-encode the image, and
    // the screenshot reader needs the original.
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      requestFullMetadata: false,
    );
    return file?.readAsBytes();
  },
);
