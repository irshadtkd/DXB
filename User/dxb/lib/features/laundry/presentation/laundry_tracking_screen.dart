import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../common/widgets/ms_card.dart';
import '../../../common/widgets/ms_error_state.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import 'cubit/laundry_tracking_cubit.dart';

class LaundryTrackingScreen extends StatelessWidget {
  const LaundryTrackingScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LaundryTrackingCubit(sl(), orderId)..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.laundryTracking),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<LaundryTrackingCubit, LaundryTrackingState>(
            builder: (context, state) {
            if (state.status == LoadStatus.loading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            if (state.status == LoadStatus.failure || state.data == null) {
              return MsErrorState(message: state.message ?? '', onRetry: () => context.read<LaundryTrackingCubit>().retry());
            }
            final d = state.data!;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(d.status, style: AppTextStyles.displayMd()),
                Text('Order #${d.orderId}', style: AppTextStyles.bodySm(color: AppColors.onSurface3)),
                const SizedBox(height: 20),
                Container(
                  height: 160,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryDim,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
                  ),
                  child: Text(AppStrings.trackingMapHint, style: AppTextStyles.bodyMd(color: AppColors.onSurface2)),
                ),
                const SizedBox(height: 24),
                ...d.steps.map((s) => ListTile(
                      leading: Icon(s.done ? Icons.check_circle : Icons.radio_button_unchecked, color: s.done ? AppColors.sage : AppColors.outline),
                      title: Text(s.title, style: AppTextStyles.bodyMd(weight: FontWeight.w600)),
                      subtitle: Text(s.time, style: AppTextStyles.bodySm()),
                    )),
                const SizedBox(height: 16),
                MsCard(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    title: Text(d.driverName, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
                    subtitle: Text(d.driverPhone, style: AppTextStyles.bodySm()),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(d.eta, style: AppTextStyles.displaySm(color: AppColors.primary, weight: FontWeight.w800)),
                        Text(AppStrings.laundryOutForDelivery, style: AppTextStyles.displayXs()),
                      ],
                    ),
                  ),
                ),
              ],
            );
            },
          ),
        ),
      ),
    );
  }
}
