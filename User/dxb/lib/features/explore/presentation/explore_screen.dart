import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_card.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(title: Text(AppStrings.exploreTitle, style: AppTextStyles.displayMd())),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(AppStrings.exploreSubtitle, style: AppTextStyles.bodyLg(color: AppColors.onSurface3)),
          const SizedBox(height: 20),
          MsCard(
            onTap: () => context.push(RoutePaths.food),
            child: ListTile(
              leading: const Icon(Icons.restaurant, color: AppColors.accent),
              title: Text(AppStrings.splashFood, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
              subtitle: Text(AppStrings.hubViewAll, style: AppTextStyles.bodySm(color: AppColors.primary)),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 12),
          MsCard(
            onTap: () => context.push(RoutePaths.laundry),
            child: ListTile(
              leading: const Icon(Icons.local_laundry_service, color: AppColors.sage),
              title: Text(AppStrings.splashLaundry, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 12),
          MsCard(
            onTap: () => context.push(RoutePaths.car),
            child: ListTile(
              leading: const Icon(Icons.directions_car, color: AppColors.primary),
              title: Text(AppStrings.splashRental, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 12),
          MsCard(
            onTap: () => context.push(RoutePaths.homeServices),
            child: ListTile(
              leading: Icon(Icons.handyman, color: AppColors.homeServicePurple),
              title: Text(AppStrings.splashHome, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 12),
          MsCard(
            onTap: () => context.push(RoutePaths.wallet),
            child: ListTile(
              leading: const Icon(Icons.account_balance_wallet, color: AppColors.accentDark),
              title: Text(AppStrings.walletTitle, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 12),
          MsCard(
            onTap: () => context.push(RoutePaths.chat('chat_sparkclean')),
            child: ListTile(
              leading: const Icon(Icons.chat_bubble_outline, color: AppColors.primary),
              title: Text(AppStrings.chatInbox, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}
