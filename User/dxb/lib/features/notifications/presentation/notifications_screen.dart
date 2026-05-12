import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../common/widgets/ms_empty_state.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import 'cubit/notifications_cubit.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationsCubit(sl())..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.notificationsTitle),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
            if (state.status == LoadStatus.loading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            if (state.items.isEmpty) {
              return MsEmptyState(title: AppStrings.notificationsEmpty);
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                final n = state.items[i];
                return ListTile(
                  tileColor: AppColors.surfaceCard,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  leading: Icon(notificationIcon(n.icon), color: n.read ? AppColors.onSurface3 : AppColors.primary),
                  title: Text(n.title, style: AppTextStyles.bodyMd(weight: FontWeight.w700)),
                  subtitle: Text(n.body, style: AppTextStyles.bodySm()),
                  trailing: Text(n.time, style: AppTextStyles.displayXs()),
                );
              },
            );
            },
          ),
        ),
      ),
    );
  }

}

IconData notificationIcon(String k) {
  return switch (k) {
    'account_balance_wallet' => Icons.account_balance_wallet_outlined,
    'local_offer' => Icons.local_offer_outlined,
    _ => Icons.notifications_outlined,
  };
}
