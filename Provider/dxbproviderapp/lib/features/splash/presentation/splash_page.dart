import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../session/domain/account_status.dart';
import '../../session/presentation/session_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _goNext());
  }

  Future<void> _goNext() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    final session = context.read<SessionCubit>().state;
    if (session.isLoggedIn && session.accountStatus == AccountStatus.approved) {
      context.go('/home');
      return;
    }
    if (session.isLoggedIn && session.accountStatus != AccountStatus.approved) {
      context.go('/account-status/${session.accountStatus.jsonName}');
      return;
    }
    if (!session.hasSeenTutorial) {
      context.go('/tutorial');
      return;
    }
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryDark, AppColors.primary, AppColors.splashGradientEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.logo, width: 80, height: 80),
              const SizedBox(height: 20),
              Text(AppStrings.appName, style: AppTextStyles.sora(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white)),
              const SizedBox(height: 8),
              Text(AppStrings.splashTagline, style: AppTextStyles.dmSans(fontSize: 13, color: Color(0xB3FFFFFF))),
              const SizedBox(height: 28),
              Text(AppStrings.splashLoading, style: AppTextStyles.dmSans(fontSize: 12, color: Color(0x99FFFFFF))),
            ],
          ),
        ),
      ),
    );
  }
}
