import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_text_styles.dart';

class MsSecondaryButton extends StatelessWidget {
  const MsSecondaryButton({super.key, required this.label, this.onPressed, this.expanded = true});

  final String label;
  final VoidCallback? onPressed;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final child = OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.onSurface2,
        side: const BorderSide(color: AppColors.outline, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
        shape: const StadiumBorder(),
        textStyle: AppTextStyles.bodyMd(weight: FontWeight.w700),
      ),
      child: Text(label),
    );
    return expanded ? SizedBox(width: double.infinity, child: child) : child;
  }
}
