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

class CarConfirmScreen extends StatelessWidget {
  const CarConfirmScreen({super.key, required this.vehicleId});

  final String vehicleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CarBookCubit(sl(), vehicleId)..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.carConfirmation),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<CarBookCubit, CarBookState>(
            builder: (context, state) {
            if (state.status != LoadStatus.success || state.data == null) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            final d = state.data!;
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: AppColors.sage, size: 72),
                  const SizedBox(height: 16),
                  Text(AppStrings.carConfirmation, style: AppTextStyles.displayLg(), textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Text('Code ${d.confirmationCode}', style: AppTextStyles.bodyMd(color: AppColors.onSurface3)),
                  const SizedBox(height: 24),
                  MsPrimaryButton(label: AppStrings.navHome, onPressed: () => context.go(RoutePaths.hub)),
                ],
              ),
            );
            },
          ),
        ),
      ),
    );
  }
}
