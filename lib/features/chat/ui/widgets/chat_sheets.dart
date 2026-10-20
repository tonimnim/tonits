import 'package:flutter/material.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/match_chat.dart';

/// Letters, digits, spaces or dashes, up to 32.
final _roomCodePattern = RegExp(r'^[A-Za-z0-9 -]{1,32}$');

/// Asks for the Friend Match room code to pin for both players.
Future<ChatDraft?> askRoomCode(BuildContext context) =>
    showModalBottomSheet<ChatDraft>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _RoomCodeSheet(),
    );

class _RoomCodeSheet extends StatefulWidget {
  const _RoomCodeSheet();

  @override
  State<_RoomCodeSheet> createState() => _RoomCodeSheetState();
}

class _RoomCodeSheetState extends State<_RoomCodeSheet> {
  final _form = GlobalKey<FormState>();
  final _code = TextEditingController();

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  void _pin() {
    if (!_form.currentState!.validate()) return;
    Navigator.of(context).pop(RoomCodeDraft(_code.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            TonitsSpace.lg,
            0,
            TonitsSpace.lg,
            TonitsSpace.lg,
          ),
          child: Form(
            key: _form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l.chatDropCodeTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 6),
                Text(
                  l.chatDropCodeHelp,
                  style: TextStyle(height: 1.4, color: p.subtleForeground),
                ),
                const SizedBox(height: TonitsSpace.md),
                TextFormField(
                  controller: _code,
                  autofocus: true,
                  maxLength: 32,
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.characters,
                  style: monoFont.copyWith(fontSize: 20, letterSpacing: 1),
                  decoration: InputDecoration(
                    hintText: l.chatRoomCode,
                    counterText: '',
                  ),
                  validator: (v) => _roomCodePattern.hasMatch((v ?? '').trim())
                      ? null
                      : l.chatRoomCodeInvalid,
                  onFieldSubmitted: (_) => _pin(),
                ),
                const SizedBox(height: TonitsSpace.md),
                PrimaryButton(label: l.chatPinCode, onPressed: _pin),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A kick-off soon, or one the player picks, always before [playBy].
Future<ChatDraft?> askKickOff(
  BuildContext context, {
  required DateTime now,
  DateTime? playBy,
}) async {
  final l = context.l10n;
  bool fits(DateTime at) =>
      at.isAfter(now) && (playBy == null || at.isBefore(playBy));
  final soon = [
    for (final (minutes, label) in [
      (15, l.chatInMinutes(15)),
      (30, l.chatInMinutes(30)),
      (60, l.chatInAnHour),
    ])
      if (_roundUp(now.add(Duration(minutes: minutes))) case final at
          when fits(at))
        (at, label),
  ];
  final picked = await showModalBottomSheet<Object>(
    context: context,
    builder: (sheet) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              TonitsSpace.lg,
              0,
              TonitsSpace.lg,
              TonitsSpace.sm,
            ),
            child: Text(
              l.chatSuggestTimeTitle,
              style: Theme.of(sheet).textTheme.headlineSmall,
            ),
          ),
          for (final (at, label) in soon)
            ListTile(
              leading: const Icon(Icons.schedule_rounded),
              title: Text(label),
              trailing: Text(
                TimeOfDay.fromDateTime(at.toLocal()).format(sheet),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () => Navigator.of(sheet).pop(at),
            ),
          ListTile(
            leading: const Icon(Icons.edit_calendar_outlined),
            title: Text(l.chatPickTime),
            onTap: () => Navigator.of(sheet).pop(_pick),
          ),
        ],
      ),
    ),
  );
  if (picked is DateTime) return TimeProposalDraft(picked);
  if (picked != _pick || !context.mounted) return null;

  final local = now.toLocal();
  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(local.add(const Duration(hours: 1))),
  );
  if (time == null || !context.mounted) return null;
  var at = DateTime(local.year, local.month, local.day, time.hour, time.minute);
  // A time already gone today means tomorrow.
  if (!at.isAfter(local)) at = at.add(const Duration(days: 1));
  if (!fits(at)) {
    showMessage(context, l.chatErrorProposedTime);
    return null;
  }
  return TimeProposalDraft(at);
}

const _pick = #pick;

/// Up to the next five minutes: 18:42 is 18:45.
DateTime _roundUp(DateTime at) {
  final local = at.toLocal();
  final extra = (5 - local.minute % 5) % 5;
  return DateTime(
    local.year,
    local.month,
    local.day,
    local.hour,
    local.minute + extra,
  );
}
