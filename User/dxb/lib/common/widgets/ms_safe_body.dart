import 'package:flutter/material.dart';

/// Applies [SafeArea] for notches, status bar, and (optionally) the home indicator.
///
/// Set [bottom] to `false` when using [Scaffold.bottomNavigationBar] that already
/// applies bottom insets (e.g. [MsBottomNav] uses [SafeArea] with `top: false`).
///
/// Set [top] to `false` only when the parent already handled top insets (e.g. some
/// [SliverAppBar] / full-bleed headers).
class MsSafeBody extends StatelessWidget {
  const MsSafeBody({
    super.key,
    required this.child,
    this.top = true,
    this.left = true,
    this.right = true,
    this.bottom = true,
    this.minimum = EdgeInsets.zero,
    this.maintainBottomViewPadding = false,
  });

  final Widget child;
  final bool top;
  final bool left;
  final bool right;
  final bool bottom;
  final EdgeInsets minimum;
  final bool maintainBottomViewPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      minimum: minimum,
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: child,
    );
  }
}
