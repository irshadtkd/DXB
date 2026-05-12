import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class MsStatusChip extends StatelessWidget {
  const MsStatusChip({super.key, required this.label, this.variant = MsStatusVariant.neutral});

  final String label;
  final MsStatusVariant variant;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (variant) {
      MsStatusVariant.success => (AppColors.sageLight, AppColors.sage),
      MsStatusVariant.warning => (AppColors.inProgressBg, AppColors.inProgressFg),
      MsStatusVariant.error => (AppColors.cancelledBg, AppColors.error),
      MsStatusVariant.neutral => (AppColors.primaryDim, AppColors.primary),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(99)),
      child: Text(label, style: AppTextStyles.bodySm(color: fg, weight: FontWeight.w700)),
    );
  }
}

enum MsStatusVariant { success, warning, error, neutral }
