import 'package:flutter/material.dart';

import '../theme.dart';
import 'section_header.dart';

/// A titled group of [SettingsRow]s on one card, separated by hairlines.
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, this.title, required this.rows});

  final String? title;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: SectionLabel(title!),
          ),
          const SizedBox(height: TonitsSpace.sm),
        ],
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (final (i, row) in rows.indexed) ...[
                if (i > 0) const Divider(indent: 52),
                row,
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// One setting: an icon, its name, the current value, and where tapping
/// leads.
class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    this.valueStyle,
    this.trailing,
    this.onTap,
    this.destructive = false,
    this.chevron = true,
  });

  final IconData icon;
  final String label;

  /// The current value, shown on the right, such as an email address.
  final String? value;
  final TextStyle? valueStyle;

  /// Replaces the chevron, such as a copy icon.
  final Widget? trailing;
  final VoidCallback? onTap;

  /// Red label and icon, for signing out.
  final bool destructive;
  final bool chevron;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final color = destructive ? p.destructive : p.foreground;
    final labelText = Text(
      label,
      style: TextStyle(
        color: color,
        fontWeight: destructive ? FontWeight.w600 : null,
      ),
    );
    return Semantics(
      button: onTap != null,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: LayoutBuilder(
              builder: (context, constraints) => Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: destructive ? p.destructive : p.subtleForeground,
                  ),
                  const SizedBox(width: 16),
                  // The label takes up to half the row and the value the
                  // rest, right-aligned; with no value the label takes it all.
                  if (value == null)
                    Expanded(child: labelText)
                  else
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth / 2,
                      ),
                      child: labelText,
                    ),
                  if (value != null) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        value!,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            valueStyle ?? TextStyle(color: p.subtleForeground),
                      ),
                    ),
                  ],
                  if (trailing != null) ...[
                    const SizedBox(width: 8),
                    trailing!,
                  ] else if (chevron && onTap != null) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: p.mutedForeground,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
