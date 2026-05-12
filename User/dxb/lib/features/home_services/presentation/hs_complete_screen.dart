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
import 'cubit/hs_cubit.dart';

class HsCompleteScreen extends StatelessWidget {
  const HsCompleteScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HsCubit(sl())..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.hsCompletion),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<HsCubit, HsState>(
            builder: (context, state) {
            if (state.status != LoadStatus.success || state.bundle == null) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            final b = state.bundle!;
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.verified, color: AppColors.sage, size: 72),
                  const SizedBox(height: 16),
                  Text(b.completionTitle, style: AppTextStyles.displayLg(), textAlign: TextAlign.center),
                  Text(b.completionSubtitle, style: AppTextStyles.bodyMd(color: AppColors.onSurface3), textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Text(b.completionAmount, style: AppTextStyles.displayMd(color: AppColors.primary)),
                  const SizedBox(height: 24),
                  MsPrimaryButton(
                    label: AppStrings.reviewSubmit,
                    onPressed: () => context.push(RoutePaths.review(orderId)),
                  ),
                  const SizedBox(height: 12),
                  TextButton(onPressed: () => context.go(RoutePaths.hub), child: Text(AppStrings.navHome)),
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
