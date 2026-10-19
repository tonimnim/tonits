import 'package:flutter/material.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/match_chat.dart';
import 'chat_bubble.dart';

/// Writing to the opponent: quick replies a tap away, a message, and under
/// + the room code and a kick-off time, each with its own kind so the
/// server never hides a code as a phone number.
class ChatComposer extends StatefulWidget {
  const ChatComposer({
    super.key,
    required this.onSend,
    required this.now,
    this.playBy,
  });

  final void Function(ChatDraft draft) onSend;
  final DateTime now;

  /// A proposed time must be before it.
  final DateTime? playBy;

  @override
  State<ChatComposer> createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer> {
  final _text = TextEditingController();

  static const _maxLength = 500;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _sendText() {
    final text = _text.text.trim();
    if (text.isEmpty) return;
    widget.onSend(TextDraft(text));
    _text.clear();
    setState(() {});
  }

  Future<void> _more() async {
    final l = context.l10n;
    final choice = await showModalBottomSheet<_More>(
      context: context,
      builder: (sheet) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.vpn_key_outlined),
              title: Text(l.chatShareRoomCode),
              onTap: () => Navigator.of(sheet).pop(_More.roomCode),
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: Text(l.chatProposeTime),
              onTap: () => Navigator.of(sheet).pop(_More.time),
            ),
          ],
        ),
      ),
    );
    if (!mounted || choice == null) return;
    final draft = choice == _More.roomCode
        ? await _askRoomCode(context)
        : await _askTime(context, widget.now, widget.playBy);
    if (draft != null) widget.onSend(draft);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final canSend = _text.text.trim().isNotEmpty;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: TonitsSpace.md),
            itemCount: QuickReply.values.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final reply = QuickReply.values[i];
              // Flat pills, no outline.
              return ActionChip(
                label: Text(quickReplyText(reply, l)),
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: p.foreground,
                ),
                backgroundColor: dark ? p.card : p.muted,
                side: BorderSide.none,
                shape: const StadiumBorder(),
                elevation: 0,
                pressElevation: 0,
                onPressed: () => widget.onSend(QuickReplyDraft(reply)),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            TonitsSpace.md,
            0,
            TonitsSpace.md,
            TonitsSpace.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RoundIconButton(
                icon: Icons.add,
                tooltip: l.chatMore,
                size: 44,
                onPressed: _more,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _text,
                  minLines: 1,
                  maxLines: 4,
                  maxLength: _maxLength,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: l.chatMessageHint,
                    counterText: '',
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              RoundIconButton(
                icon: Icons.arrow_upward,
                tooltip: l.chatSend,
                size: 44,
                background: canSend ? p.primary : null,
                foreground: canSend ? p.onPrimary : null,
                onPressed: canSend ? _sendText : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum _More { roomCode, time }

/// Letters, digits, spaces or dashes, up to 32.
final _roomCodePattern = RegExp(r'^[A-Za-z0-9 -]{1,32}$');

Future<ChatDraft?> _askRoomCode(BuildContext context) =>
    showModalBottomSheet<ChatDraft>(
      context: context,
      isScrollControlled: true,
      builder: (sheet) => _RoomCodeSheet(),
    );

class _RoomCodeSheet extends StatefulWidget {
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

  void _share() {
    if (!_form.currentState!.validate()) return;
    Navigator.of(context).pop(RoomCodeDraft(_code.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
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
                  l.chatShareRoomCode,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: TonitsSpace.md),
                TextFormField(
                  controller: _code,
                  autofocus: true,
                  maxLength: 32,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.characters,
                  style: monoFont.copyWith(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: l.chatRoomCode,
                    counterText: '',
                  ),
                  validator: (v) => _roomCodePattern.hasMatch((v ?? '').trim())
                      ? null
                      : l.chatRoomCodeInvalid,
                  onFieldSubmitted: (_) => _share(),
                ),
                const SizedBox(height: TonitsSpace.md),
                PrimaryButton(label: l.chatShare, onPressed: _share),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A kick-off soon, or one the player picks, kept before [playBy].
Future<ChatDraft?> _askTime(
  BuildContext context,
  DateTime now,
  DateTime? playBy,
) async {
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
        children: [
          for (final (at, label) in soon)
            ListTile(
              leading: const Icon(Icons.schedule),
              title: Text(label),
              trailing: Text(
                TimeOfDay.fromDateTime(at.toLocal()).format(sheet),
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
