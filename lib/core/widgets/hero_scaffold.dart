import 'package:flutter/material.dart';

import '../l10n.dart';
import '../theme.dart';
import 'round_icon_button.dart';

/// A screen with a softly tinted top ([hero]) and its content on a sheet
/// with rounded top corners laid over it. The app bar is clear over the
/// hero, with a round back button, and turns solid once content scrolls
/// under it.
class HeroScaffold extends StatefulWidget {
  const HeroScaffold({
    super.key,
    required this.hero,
    required this.children,
    this.title,
    this.actions = const [],
    this.onRefresh,
    this.bottom,
  });

  /// The tinted top's content. It sits below the app bar.
  final Widget hero;

  /// The sheet's content, top to bottom.
  final List<Widget> children;

  /// A quiet line in the app bar, such as the competition's name.
  final String? title;

  /// Round buttons on the right of the app bar.
  final List<Widget> actions;
  final Future<void> Function()? onRefresh;

  /// Pinned below the content, such as the screen's main action.
  final Widget? bottom;

  /// How far the sheet reaches up over the hero.
  static const overlap = 28.0;

  /// The hero's wash: a deeper tint at the top fading to the soft tint.
  static Gradient wash(TonitsPalette p) => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.lerp(p.soft, p.primary, 0.16)!, p.soft],
  );

  @override
  State<HeroScaffold> createState() => _HeroScaffoldState();
}

class _HeroScaffoldState extends State<HeroScaffold> {
  bool _scrolled = false;

  bool _onScroll(ScrollNotification n) {
    final scrolled = n.metrics.axis == Axis.vertical && n.metrics.pixels > 24;
    if (scrolled != _scrolled) setState(() => _scrolled = scrolled);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final top = MediaQuery.paddingOf(context).top;
    final canPop = Navigator.of(context).canPop();
    // A tab's first screen has nothing for a bar to hold.
    final bare = widget.title == null && widget.actions.isEmpty && !canPop;

    Widget list = ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        Container(
          decoration: BoxDecoration(gradient: HeroScaffold.wash(p)),
          padding: EdgeInsets.fromLTRB(
            TonitsSpace.md,
            // A bare top leaves room under the status bar, so the header
            // doesn't crowd it.
            bare ? top + TonitsSpace.xl : top + kToolbarHeight + 4,
            TonitsSpace.md,
            TonitsSpace.xl + HeroScaffold.overlap,
          ),
          child: widget.hero,
        ),
        Transform.translate(
          offset: const Offset(0, -HeroScaffold.overlap),
          child: Material(
            color: p.background,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(TonitsRadius.sheet),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                TonitsSpace.md,
                20,
                TonitsSpace.md,
                TonitsSpace.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widget.children,
              ),
            ),
          ),
        ),
      ],
    );
    if (widget.onRefresh != null) {
      list = RefreshIndicator(
        edgeOffset: bare ? top : top + kToolbarHeight,
        onRefresh: widget.onRefresh!,
        child: list,
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: _scrolled ? p.background : Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: bare ? 0 : null,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leadingWidth: 64,
        leading: canPop
            ? Padding(
                padding: const EdgeInsets.only(left: TonitsSpace.md),
                child: Center(
                  child: RoundIconButton(
                    icon: Icons.arrow_back,
                    tooltip: context.l10n.back,
                    background: p.card.withValues(alpha: 0.85),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),
              )
            : null,
        title: widget.title == null
            ? null
            : Text(
                widget.title!,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                  color: p.subtleForeground,
                ),
              ),
        actions: [
          ...widget.actions,
          if (widget.actions.isNotEmpty) const SizedBox(width: TonitsSpace.md),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: list,
      ),
      bottomNavigationBar: widget.bottom,
    );
  }
}
