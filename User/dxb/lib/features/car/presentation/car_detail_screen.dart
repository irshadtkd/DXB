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
import '../../../domain/entities/entities.dart';
import 'cubit/car_cubit.dart';

class CarDetailScreen extends StatelessWidget {
  const CarDetailScreen({super.key, required this.vehicleId});

  final String vehicleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CarCubit(sl())..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.carDetails),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<CarCubit, CarState>(
            builder: (context, state) {
            if (state.status != LoadStatus.success) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            Vehicle? v;
            for (final x in state.vehicles) {
              if (x.id == vehicleId) {
                v = x;
                break;
              }
            }
            v ??= state.vehicles.isNotEmpty ? state.vehicles.first : null;
            if (v == null) return const Center(child: Text('—'));
            final vehicle = v;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(vehicle.name, style: AppTextStyles.displayLg()),
                Text(vehicle.category, style: AppTextStyles.bodyMd(color: AppColors.onSurface3)),
                const SizedBox(height: 16),
                Wrap(spacing: 8, children: vehicle.features.map((f) => Chip(label: Text(f))).toList()),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text(vehicle.pricePerDay, style: AppTextStyles.displayLg(color: AppColors.primary)),
                    Text(AppStrings.carPerDay, style: AppTextStyles.bodySm()),
                    const SizedBox(width: 16),
                    Text(vehicle.pricePerHour, style: AppTextStyles.displaySm()),
                    Text(AppStrings.carPerHour, style: AppTextStyles.bodySm()),
                  ],
                ),
                const SizedBox(height: 32),
                MsPrimaryButton(
                  label: AppStrings.carBookNow,
                  onPressed: () => context.push(RoutePaths.carBook(vehicle.id)),
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
