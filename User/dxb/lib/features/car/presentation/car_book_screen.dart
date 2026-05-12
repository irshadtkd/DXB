import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../common/widgets/ms_primary_button.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import 'cubit/car_book_cubit.dart';

class CarBookScreen extends StatelessWidget {
  const CarBookScreen({super.key, required this.vehicleId});

  final String vehicleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CarBookCubit(sl(), vehicleId)..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.carBookingTitle),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<CarBookCubit, CarBookState>(
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
                Text(d.vehicleName, style: AppTextStyles.displayLg()),
                const SizedBox(height: 12),
                ListTile(
                  title: Text(AppStrings.carPickup, style: AppTextStyles.bodyMd(weight: FontWeight.w600)),
                  subtitle: Text(d.pickupLocation),
                ),
                ListTile(
                  title: Text(AppStrings.carReturn, style: AppTextStyles.bodyMd(weight: FontWeight.w600)),
                  subtitle: Text(d.returnLocation),
                ),
                ListTile(title: Text(AppStrings.carStart), subtitle: Text(d.startDate)),
                ListTile(title: Text(AppStrings.carEnd), subtitle: Text(d.endDate)),
                const Divider(),
                ...d.addOns.map((a) => ListTile(title: Text(a.label), trailing: Text(a.price))),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.commonSubtotal, style: AppTextStyles.bodySm()),
                    Text(d.baseFare, style: AppTextStyles.bodySm()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.commonTaxes),
                    Text(d.taxes, style: AppTextStyles.bodySm()),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.commonTotal, style: AppTextStyles.displaySm(weight: FontWeight.w800)),
                    Text(d.total, style: AppTextStyles.displaySm(color: AppColors.primary, weight: FontWeight.w800)),
                  ],
                ),
                const SizedBox(height: 24),
                MsPrimaryButton(
                  label: AppStrings.carBookNow,
                  onPressed: () => context.push(RoutePaths.carConfirm(vehicleId)),
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
