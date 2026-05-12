import 'package:flutter/material.dart';

import '../../core/strings/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_text_styles.dart';
import 'ms_primary_button.dart';

class MsDialogs {
  static Future<void> alert(BuildContext context, {required String title, String? message}) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusLg)),
        title: Text(title, style: AppTextStyles.displaySm()),
        content: message != null ? Text(message, style: AppTextStyles.bodyMd()) : null,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppStrings.commonOk, style: AppTextStyles.bodyMd(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  static Future<bool> confirm(BuildContext context, {required String title, String? message}) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusLg)),
        title: Text(title, style: AppTextStyles.displaySm()),
        content: message != null ? Text(message, style: AppTextStyles.bodyMd()) : null,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(AppStrings.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(AppStrings.commonOk, style: const TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

class MsBottomSheets {
  static Future<T?> show<T>(BuildContext context, {required Widget child, String? title}) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(ctx).bottom),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusXl)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingLg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: AppColors.outline,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                  ),
                  if (title != null) ...[
                    Text(title, style: AppTextStyles.displaySm(weight: FontWeight.w800)),
                    const SizedBox(height: 12),
                  ],
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showCouponSheet(BuildContext context, {required String code, required String description}) {
  MsBottomSheets.show<void>(
    context,
    title: code,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(description, style: AppTextStyles.bodyMd()),
        const SizedBox(height: 16),
        MsPrimaryButton(label: AppStrings.commonOk, onPressed: () => Navigator.pop(context)),
      ],
    ),
  );
}
