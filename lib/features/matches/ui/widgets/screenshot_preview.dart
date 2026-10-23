import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';

enum PreviewChoice { confirm, pickAnother }

/// Shows a picked screenshot big, to check it's the right one before it
/// counts. Null when the player closes it.
Future<PreviewChoice?> previewScreenshot(
  BuildContext context,
  Uint8List bytes, {
  required String title,
  required String confirmLabel,
}) => showModalBottomSheet<PreviewChoice>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (sheet) {
    final p = sheet.palette;
    final l = sheet.l10n;
    final size = MediaQuery.sizeOf(sheet);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        TonitsSpace.lg,
        0,
        TonitsSpace.lg,
        TonitsSpace.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: Theme.of(sheet).textTheme.headlineSmall),
          const SizedBox(height: TonitsSpace.md),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: size.height * 0.55),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(TonitsRadius.tile),
              child: ColoredBox(
                color: p.muted,
                child: ScreenshotImage(
                  bytes: bytes,
                  width: size.width,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: TonitsSpace.md),
          PrimaryButton(
            label: confirmLabel,
            onPressed: () => Navigator.of(sheet).pop(PreviewChoice.confirm),
          ),
          const SizedBox(height: TonitsSpace.sm),
          SecondaryButton(
            label: l.matchScreenshotPickAnother,
            onPressed: () => Navigator.of(sheet).pop(PreviewChoice.pickAnother),
          ),
        ],
      ),
    );
  },
);

/// A picked screenshot, decoded only as big as it's shown: a full-size
/// phone screenshot decoded at full resolution would cost tens of
/// megabytes for a thumbnail.
class ScreenshotImage extends StatelessWidget {
  const ScreenshotImage({
    super.key,
    required this.bytes,
    required this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  final Uint8List bytes;
  final double width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final ratio = MediaQuery.devicePixelRatioOf(context);
    return Image.memory(
      bytes,
      width: width,
      height: height,
      fit: fit,
      cacheWidth: (width * ratio).round(),
      gaplessPlayback: true,
      excludeFromSemantics: true,
      errorBuilder: (_, _, _) => SizedBox(
        width: width,
        height: height ?? width * 0.6,
        child: Icon(Icons.broken_image_outlined, color: p.mutedForeground),
      ),
    );
  }
}
