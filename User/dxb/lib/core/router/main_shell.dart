import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/widgets/ms_bottom_nav.dart';
import '../../common/widgets/ms_safe_body.dart';
import '../../core/theme/app_colors.dart';
import 'route_paths.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  int _indexFromLocation(String loc) {
    if (loc.startsWith(RoutePaths.hub)) return 0;
    if (loc.startsWith(RoutePaths.ordersTab)) return 1;
    if (loc.startsWith(RoutePaths.explore)) return 2;
    if (loc.startsWith(RoutePaths.profileTab)) return 3;
    return navigationShell.currentIndex;
  }

  void _goBranch(BuildContext context, int i) {
    // Tab targets are full paths; `go` updates the correct shell branch (go_router 15+).
    switch (i) {
      case 0:
        context.go(RoutePaths.hub);
        break;
      case 1:
        context.go(RoutePaths.ordersTab);
        break;
      case 2:
        context.go(RoutePaths.explore);
        break;
      case 3:
        context.go(RoutePaths.profileTab);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final idx = _indexFromLocation(GoRouterState.of(context).uri.toString());
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: MsSafeBody(
        bottom: false,
        child: navigationShell,
      ),
      bottomNavigationBar: MsBottomNav(
        currentIndex: idx,
        onSelect: (i) => _goBranch(context, i),
      ),
    );
  }
}
