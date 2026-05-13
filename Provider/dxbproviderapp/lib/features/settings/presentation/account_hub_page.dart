import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../session/presentation/session_cubit.dart';

class AccountHubPage extends StatelessWidget {
  const AccountHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.accountTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(AppStrings.accountProfile),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/account/settings/profile'),
          ),
          AccountHubPage._tile(Icons.currency_exchange, AppStrings.accountEarnings, () => context.push('/account/earnings')),
          AccountHubPage._tile(Icons.receipt_long, AppStrings.accountPayouts, () => context.push('/account/payouts')),
          AccountHubPage._tile(Icons.account_balance, AppStrings.accountBank, () => context.push('/account/bank')),
          AccountHubPage._tile(Icons.insights, AppStrings.accountAnalytics, () => context.push('/account/analytics/overview')),
          AccountHubPage._tile(Icons.star_border, AppStrings.accountReviews, () => context.push('/account/reviews')),
          AccountHubPage._tile(Icons.map_outlined, AppStrings.serviceAreasTitle, () => context.push('/account/settings/service-areas')),
          AccountHubPage._tile(Icons.schedule, AppStrings.operatingHoursTitle, () => context.push('/account/settings/hours')),
          AccountHubPage._tile(Icons.groups_outlined, AppStrings.teamRolesTitle, () => context.push('/account/settings/team')),
          AccountHubPage._tile(Icons.notifications_active_outlined, AppStrings.notificationPrefsTitle, () => context.push('/account/settings/notifications')),
          AccountHubPage._tile(Icons.grid_view, AppStrings.accountWebTools, () => context.push('/account/web-tools')),
          AccountHubPage._tile(Icons.help_outline, AppStrings.accountHelp, () => context.push('/account/help')),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: Text(AppStrings.signOut, style: AppTextStyles.dmSans(color: AppColors.error, fontWeight: FontWeight.w700)),
            onTap: () async {
              await context.read<SessionCubit>().logout();
              if (context.mounted) context.go('/login');
            },
          ),
        ],
      ),
    );
  }

  static Widget _tile(IconData i, String t, VoidCallback onTap) => ListTile(
        leading: Icon(i, color: AppColors.primary),
        title: Text(t),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      );
}
