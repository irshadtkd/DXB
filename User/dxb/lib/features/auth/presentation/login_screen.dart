import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_primary_button.dart';
import '../../../common/widgets/ms_text_field.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phone = TextEditingController(text: '+91 98765 43210');
  final _otp = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    _phone.dispose();
    for (final c in _otp) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(int i, String v) {
    if (v.length == 1 && i < 5) {
      _focusNodes[i + 1].requestFocus();
    }
    if (v.isEmpty && i > 0) {
      _focusNodes[i - 1].requestFocus();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  MsBackButton(onTap: () => context.go(RoutePaths.onboarding)),
                  const Spacer(),
                  Text(AppStrings.appName, style: AppTextStyles.displaySm(color: AppColors.primary, weight: FontWeight.w800)),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 24),
              Text(AppStrings.authWelcome, style: AppTextStyles.displayLg()),
              const SizedBox(height: 8),
              Text(AppStrings.authPhoneHint, style: AppTextStyles.bodyLg(color: AppColors.onSurface3)),
              const SizedBox(height: 28),
              Text(
                AppStrings.authPhoneLabel,
                style: AppTextStyles.displayXs(color: AppColors.onSurface2),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                      border: Border.all(color: AppColors.outline, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Text('🇮🇳', style: AppTextStyles.bodyLg()),
                        Icon(Icons.expand_more, size: 16, color: AppColors.onSurface3),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MsTextField(
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(AppStrings.authOtpLabel, style: AppTextStyles.displayXs(color: AppColors.onSurface2)),
              const SizedBox(height: 8),
              Row(
                children: List.generate(6, (i) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: i == 0 ? 0 : 6, right: i == 5 ? 0 : 0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: TextField(
                          controller: _otp[i],
                          focusNode: _focusNodes[i],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: AppTextStyles.displayLg(color: AppColors.primary, weight: FontWeight.w800),
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: i < 3 ? AppColors.primary : AppColors.outline,
                                width: i < 3 ? 2 : 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: i < 3 ? AppColors.primary : AppColors.outline,
                                width: i < 3 ? 2 : 1.5,
                              ),
                            ),
                          ),
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (v) => _onOtpChanged(i, v),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text.rich(
                  TextSpan(
                    style: AppTextStyles.bodySm(color: AppColors.onSurface3),
                    children: [
                      TextSpan(text: AppStrings.authResend),
                      TextSpan(
                        text: '00:42',
                        style: AppTextStyles.bodySm(color: AppColors.primary, weight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              MsPrimaryButton(
                label: AppStrings.authVerify,
                onPressed: () => context.go(RoutePaths.hub),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.outline.withValues(alpha: 0.8))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(AppStrings.authOrContinue, style: AppTextStyles.bodySm(color: AppColors.onSurface3)),
                  ),
                  Expanded(child: Divider(color: AppColors.outline.withValues(alpha: 0.8))),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.g_mobiledata, size: 28),
                      label: Text(AppStrings.authGoogle),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusMd)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.apple, size: 24),
                      label: Text(AppStrings.authApple),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusMd)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
