import 'package:flutter/material.dart';

import '../../core/strings/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'ms_primary_button.dart';

class MsEmptyState extends StatelessWidget {
  const MsEmptyState({super.key, this.title, this.subtitle, this.onRetry});

  final String? title;
  final String? subtitle;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 56, color: AppColors.onSurface3.withValues(alpha: 0.5)),
            const SizedBox(height: 12),
            Text(title ?? AppStrings.commonEmptyTitle, style: AppTextStyles.displaySm(), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              subtitle ?? AppStrings.commonEmptySubtitle,
              style: AppTextStyles.bodyMd(),
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
