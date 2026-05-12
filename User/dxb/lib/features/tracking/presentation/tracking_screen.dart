import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import 'cubit/tracking_cubit.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TrackingCubit(sl(), orderId)..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.trackingTitle),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<TrackingCubit, TrackingState>(
            builder: (context, state) {
            if (state.status != LoadStatus.success || state.data == null) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            final d = state.data!;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(d.restaurant, style: AppTextStyles.displayMd()),
                Text('${d.orderId} · ${d.status}', style: AppTextStyles.bodySm(color: AppColors.onSurface3)),
                const SizedBox(height: 16),
                Container(
                  height: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.primaryDim, borderRadius: BorderRadius.circular(AppDimensions.radiusXl)),
                  child: Text(d.mapHint, textAlign: TextAlign.center, style: AppTextStyles.bodyMd(color: AppColors.onSurface2)),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: Text(d.riderName, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
                  subtitle: Text('★ ${d.riderRating} · ETA ${d.eta}', style: AppTextStyles.bodySm()),
                ),
                ...d.steps.map((s) => ListTile(
                      leading: Icon(s.done ? Icons.check_circle : Icons.radio_button_unchecked, color: s.done ? AppColors.sage : AppColors.outline),
                      title: Text(s.label, style: AppTextStyles.bodyMd(weight: FontWeight.w600)),
                    )),
              ],
            );
            },
          ),
        ),
      ),
    );
  }
}
