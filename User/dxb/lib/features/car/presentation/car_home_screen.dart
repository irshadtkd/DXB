import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../common/widgets/ms_card.dart';
import '../../../common/widgets/ms_error_state.dart';
import '../../../common/widgets/ms_loader.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import 'cubit/car_cubit.dart';

class CarHomeScreen extends StatelessWidget {
  const CarHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CarCubit(sl())..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.carTitle),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<CarCubit, CarState>(
            builder: (context, state) {
            if (state.status == LoadStatus.loading) return const MsLoader();
            if (state.status == LoadStatus.failure) {
              return MsErrorState(message: state.message ?? '', onRetry: () => context.read<CarCubit>().retry());
            }
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: state.vehicles.length,
              itemBuilder: (_, i) {
                final v = state.vehicles[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: MsCard(
                    onTap: () => context.push(RoutePaths.carDetail(v.id)),
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 120,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: v.gradient.map((h) => Color(int.parse('FF${h.replaceAll('#', '')}', radix: 16))).toList(),
                                  ),
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusXl)),
                                ),
                              ),
                              Center(child: Text(v.imageEmoji, style: const TextStyle(fontSize: 56))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(v.name, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, size: 14, color: AppColors.accent),
                                      Text(' ${v.rating}', style: AppTextStyles.bodySm(weight: FontWeight.w600)),
                                    ],
                                  ),
                                ],
                              ),
                              Text(v.category, style: AppTextStyles.bodySm()),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(v.pricePerDay, style: AppTextStyles.displaySm(color: AppColors.primary, weight: FontWeight.w800)),
                                  Text(AppStrings.carPerDay, style: AppTextStyles.bodySm()),
                                  const Spacer(),
                                  Text('${v.trips} trips', style: AppTextStyles.bodySm()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
