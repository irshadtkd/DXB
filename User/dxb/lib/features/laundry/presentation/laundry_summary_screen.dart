import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../common/widgets/ms_card.dart';
import '../../../common/widgets/ms_primary_button.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import 'cubit/laundry_summary_cubit.dart';

class LaundrySummaryScreen extends StatelessWidget {
  const LaundrySummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LaundrySummaryCubit(sl())..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.laundryOrderSummary),
        body: MsSafeBody(
          top: false,
          bottom: false,
          child: BlocBuilder<LaundrySummaryCubit, LaundrySummaryState>(
            builder: (context, state) {
            if (state.status != LoadStatus.success || state.data == null) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            final d = state.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(color: AppColors.sageLight, shape: BoxShape.circle),
                      child: const Icon(Icons.check_circle, color: AppColors.sage, size: 32),
                    ),
                    const SizedBox(height: 12),
                    Text(AppStrings.laundryOrderConfirmed, style: AppTextStyles.displaySm(weight: FontWeight.w800)),
                    Text('Order #${d.orderId} · ${d.provider}', style: AppTextStyles.bodySm(color: AppColors.onSurface3)),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.primaryDim, borderRadius: BorderRadius.circular(AppDimensions.radiusLg)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(AppStrings.laundryPickupColumn, style: AppTextStyles.displayXs()),
                            const Icon(Icons.arrow_upward, color: AppColors.primary),
                            Text(d.pickupDate, style: AppTextStyles.displaySm(color: AppColors.primary, weight: FontWeight.w700)),
                            Text(d.pickupSlot, style: AppTextStyles.bodySm(weight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 72, color: AppColors.outline),
                      Expanded(
                        child: Column(
                          children: [
                            Text(AppStrings.laundryDeliveryColumn, style: AppTextStyles.displayXs()),
                            const Icon(Icons.arrow_downward, color: AppColors.sage),
                            Text(d.deliveryDate, style: AppTextStyles.displaySm(color: AppColors.sage, weight: FontWeight.w700)),
                            Text(d.deliverySlot, style: AppTextStyles.bodySm(weight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(AppStrings.laundryItems, style: AppTextStyles.displayXs(color: AppColors.onSurface2)),
                const SizedBox(height: 8),
                MsCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      for (var i = 0; i < d.items.length; i++) ...[
                        if (i > 0) const Divider(height: 1),
                        ListTile(
                          leading: Text(d.items[i].emoji, style: const TextStyle(fontSize: 22)),
                          title: Text(d.items[i].title, style: AppTextStyles.bodyMd(weight: FontWeight.w600)),
                          subtitle: Text(d.items[i].subtitle, style: AppTextStyles.bodySm()),
                          trailing: Text(d.items[i].price, style: AppTextStyles.bodyMd(weight: FontWeight.w700)),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(AppStrings.laundryCharges, style: AppTextStyles.displayXs(color: AppColors.onSurface2)),
                const SizedBox(height: 8),
                MsCard(
                  child: Column(
                    children: d.charges
                        .map((c) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(c.label, style: AppTextStyles.bodySm(color: AppColors.onSurface2)),
                                  Text(
                                    c.value,
                                    style: AppTextStyles.bodySm(
                                      weight: FontWeight.w600,
                                      color: c.highlight == 'sage'
                                          ? AppColors.sage
                                          : c.highlight == 'error'
                                              ? AppColors.error
                                              : AppColors.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.commonTotal, style: AppTextStyles.bodyMd(weight: FontWeight.w700)),
                    Text(d.total, style: AppTextStyles.displaySm(color: AppColors.primary, weight: FontWeight.w800)),
                  ],
                ),
                const SizedBox(height: 8),
                Text('${AppStrings.laundryPayWithPrefix} ${d.paymentMethod}', style: AppTextStyles.bodySm(color: AppColors.onSurface3)),
                    ],
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: MsPrimaryButton(
                      label: '${AppStrings.laundryPay} · ${d.total}',
                      onPressed: () => context.push('${RoutePaths.laundryTracking}/LND-7821'),
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
