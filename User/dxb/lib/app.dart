import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/strings/app_strings.dart';
import 'core/theme/app_theme.dart';

class MultiServeApp extends StatelessWidget {
  const MultiServeApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: router,
    );
  }
}
