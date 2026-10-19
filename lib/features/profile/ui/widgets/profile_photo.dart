import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/error_text.dart';
import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../account/application/account_providers.dart';
import '../../../account/application/photo.dart';

/// The player's photo on their profile. Tapping it picks a new one from
/// their photos, uploads it and shows it.
class ProfilePhoto extends ConsumerStatefulWidget {
  const ProfilePhoto({super.key, required this.name});

  final String name;

  @override
  ConsumerState<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends ConsumerState<ProfilePhoto> {
  bool _uploading = false;

  Future<void> _change() async {
    if (_uploading) return;
    final l = context.l10n;
    final bytes = await ref.read(photoPickerProvider)();
    if (bytes == null || !mounted) return;
    setState(() => _uploading = true);
    String message;
    try {
      await ref.read(accountServiceProvider).changePhoto(bytes);
      message = l.profilePhotoUpdated;
    } on PhotoProblem catch (e) {
      message = e.message;
    } catch (e) {
      message = describeError(e, l);
    }
    if (!mounted) return;
    setState(() => _uploading = false);
    showMessage(context, message);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final image = ref.watch(myAvatarProvider).value;
    return Semantics(
      container: true,
      button: true,
      label: context.l10n.profileChangePhoto,
      child: GestureDetector(
        onTap: _change,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: p.card, shape: BoxShape.circle),
              child: InitialsAvatar(name: widget.name, size: 80, image: image),
            ),
            if (_uploading)
              Positioned.fill(
                child: Container(
                  margin: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: p.foreground.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox.square(
                    dimension: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: p.onPrimary,
                    ),
                  ),
                ),
              ),
            // Flat: a ring in the card colour sets it off the photo.
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: p.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: p.card, width: 3),
                ),
                child: Icon(
                  Icons.photo_camera_outlined,
                  size: 14,
                  color: p.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
