import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_widgets.dart';

/// Optional entry: deep links may land here; router usually sends users to [LoginPage].
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 56, 24, 32),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
            ),
            child: Column(
              children: [
                const Icon(Icons.storefront_rounded, size: 48, color: Color(0xB3FFFFFF)),
                const SizedBox(height: 12),
                Text(AppStrings.welcomeTitle, textAlign: TextAlign.center, style: AppTextStyles.sora(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white)),
                const SizedBox(height: 8),
                Text(AppStrings.welcomeSubtitle, textAlign: TextAlign.center, style: AppTextStyles.dmSans(fontSize: 13, color: Color(0xCCFFFFFF))),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppPrimaryButton(
                    label: AppStrings.welcomeSignIn,
                    onPressed: () => context.push('/login'),
                  ),
                  const SizedBox(height: 12),
                  AppOutlineButton(
                    label: AppStrings.welcomeCreateAccount,
                    onPressed: () => context.push('/register/business'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
