import 'package:flutter/material.dart';

import '../../../../core/l10n.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/match_chat.dart';
import 'chat_bubble.dart';

/// Writing to the opponent: quick replies a tap away, then the message and
/// its send button. The room code and kick-off have their own buttons on
/// the game plan above.
class ChatComposer extends StatefulWidget {
  const ChatComposer({super.key, required this.opponent, required this.onSend});

  final String opponent;
  final void Function(ChatDraft draft) onSend;

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

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l = context.l10n;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final canSend = _text.text.trim().isNotEmpty;
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
        Padding(
          padding: const EdgeInsets.fromLTRB(
            TonitsSpace.md,
            10,
            TonitsSpace.md,
            TonitsSpace.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: _text,
                  minLines: 1,
                  maxLines: 4,
                  maxLength: _maxLength,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (_) => setState(() {}),
                  onSubmitted: (_) => _sendText(),
                  decoration: InputDecoration(
                    hintText: l.chatMessageHint(widget.opponent),
                    counterText: '',
                    isDense: true,
                    filled: true,
                    fillColor: p.card,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: p.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: p.border),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              RoundIconButton(
                icon: Icons.send_rounded,
                tooltip: l.chatSend,
                size: 48,
                background: canSend ? p.primary : (dark ? p.card : p.muted),
                foreground: canSend ? p.onPrimary : p.mutedForeground,
                onPressed: canSend ? _sendText : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
