import 'package:flutter/material.dart';

import '../../core/strings/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'ms_primary_button.dart';

class MsErrorState extends StatelessWidget {
  const MsErrorState({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_rounded, size: 56, color: AppColors.error),
            const SizedBox(height: 12),
            Text(AppStrings.commonErrorTitle, style: AppTextStyles.displaySm()),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTextStyles.bodyMd(color: AppColors.onSurface2),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              MsPrimaryButton(label: AppStrings.commonRetry, onPressed: onRetry),
            ],
          ],
        ),
      ),
    );
  }
}
