import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../common/widgets/ms_primary_button.dart';
import '../../../common/widgets/ms_text_field.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import 'cubit/checkout_cubit.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckoutCubit(sl(), orderId)..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.checkoutTitle),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<CheckoutCubit, CheckoutState>(
            builder: (context, state) {
            if (state.status == LoadStatus.loading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            if (state.status == LoadStatus.failure || state.data == null) {
              return Center(child: Text(state.message ?? AppStrings.commonErrorTitle));
            }
            final d = state.data!;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(d.restaurant, style: AppTextStyles.displayMd()),
                const SizedBox(height: 12),
                ...d.items.map((i) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(i.name, style: AppTextStyles.bodyMd())),
                          Text(i.price, style: AppTextStyles.bodyMd(weight: FontWeight.w600)),
                        ],
                      ),
                    )),
                const Divider(height: 24),
                _row(AppStrings.commonSubtotal, d.subtotal),
                _row(AppStrings.commonDeliveryFee, d.deliveryFee, highlight: AppColors.sage),
                _row(AppStrings.commonGst, d.gst),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.commonTotal, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
                    Text(d.total, style: AppTextStyles.displaySm(color: AppColors.primary, weight: FontWeight.w800)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: MsTextField(hint: AppStrings.checkoutPromoHint)),
                    const SizedBox(width: 10),
                    FilledButton(onPressed: () {}, child: Text(AppStrings.checkoutApply)),
                  ],
                ),
                const SizedBox(height: 16),
                Text(AppStrings.checkoutPaymentMethod, style: AppTextStyles.displayXs(color: AppColors.onSurface3)),
                const SizedBox(height: 12),
                ...d.paymentMethods.map((p) {
                  final sel = p.id == state.selectedPaymentId;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () => context.read<CheckoutCubit>().selectPayment(p.id),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                          border: Border.all(color: sel ? AppColors.primary : AppColors.outline, width: sel ? 2 : 1.5),
                          color: sel ? AppColors.primaryDim : AppColors.surfaceCard,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [Color(0xFF1A237E), Color(0xFF3949AB)]),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text('UPI', style: AppTextStyles.displayXs(color: Colors.white)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Text(p.label, style: AppTextStyles.bodyMd(weight: FontWeight.w600))),
                            if (sel) const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 12),
                MsPrimaryButton(
                  label: '${AppStrings.checkoutPlaceOrder} · ${d.total}',
                  onPressed: () => context.push(RoutePaths.tracking(orderId)),
                ),
                const SizedBox(height: 8),
                Center(child: Text(AppStrings.checkoutSecure, style: AppTextStyles.bodySm(color: AppColors.onSurface3))),
              ],
            );
            },
          ),
        ),
      ),
    );
  }

  Widget _row(String a, String b, {Color? highlight}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(a, style: AppTextStyles.bodySm(color: AppColors.onSurface3)),
          Text(b, style: AppTextStyles.bodySm(color: highlight ?? AppColors.onSurface, weight: highlight != null ? FontWeight.w600 : null)),
        ],
      ),
    );
  }
}
