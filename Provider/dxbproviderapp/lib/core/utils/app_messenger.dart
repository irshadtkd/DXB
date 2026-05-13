import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import '../theme/app_colors.dart';

void showAppErrorBanner(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  messenger
    ..clearMaterialBanners()
    ..showMaterialBanner(
      MaterialBanner(
        content: Text(message, style: const TextStyle(color: AppColors.textPrimary)),
        backgroundColor: AppColors.bgCard,
        leading: const Icon(Icons.error_outline, color: AppColors.error),
        actions: [
          TextButton(
            onPressed: messenger.clearMaterialBanners,
            child: const Text(AppStrings.dismiss),
          ),
        ],
      ),
    );
}

void showAppSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
