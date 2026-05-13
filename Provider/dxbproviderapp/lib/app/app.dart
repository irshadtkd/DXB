import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:dxbproviderapp/core/constants/app_strings.dart';
import 'package:dxbproviderapp/core/di/service_locator.dart';
import 'package:dxbproviderapp/core/theme/app_theme.dart';
import 'package:dxbproviderapp/features/session/presentation/session_cubit.dart';

class ProviderApp extends StatelessWidget {
  const ProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<SessionCubit>(),
      child: MaterialApp.router(
        title: AppStrings.appName,
        theme: AppTheme.light(),
        routerConfig: sl<GoRouter>(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
