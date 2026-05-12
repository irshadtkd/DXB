import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../common/widgets/ms_card.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import 'cubit/hs_cubit.dart';

class HsHomeScreen extends StatelessWidget {
  const HsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HsCubit(sl())..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(
          title: AppStrings.hsTitle,
          gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryLight]),
        ),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<HsCubit, HsState>(
            builder: (context, state) {
            if (state.status != LoadStatus.success || state.bundle == null) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            final b = state.bundle!;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryLight]),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.25),
                          border: Border.all(color: AppColors.accent.withValues(alpha: 0.5)),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(AppStrings.hsSameDay, style: AppTextStyles.displayXs(color: AppColors.accent)),
                      ),
                      const SizedBox(height: 8),
                      Text(AppStrings.hsHeroTitle, style: AppTextStyles.displayLg(color: Colors.white)),
                      Text(AppStrings.hsHeroSub, style: AppTextStyles.bodySm(color: Colors.white70)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.1),
                  itemCount: b.services.length,
                  itemBuilder: (_, i) {
                    final s = b.services[i];
                    return MsCard(
                      onTap: () => context.push(RoutePaths.homeServiceDetail(s.id)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(_mapIcon(s.icon), color: AppColors.homeServicePurple),
                          const Spacer(),
                          Text(s.title, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
                          Text(s.priceFrom, style: AppTextStyles.bodySm()),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
            },
          ),
        ),
      ),
    );
  }

  IconData _mapIcon(String k) {
    return switch (k) {
      'plumbing' => Icons.plumbing,
      'carpenter' => Icons.carpenter,
      'cleaning_services' => Icons.cleaning_services,
      _ => Icons.electrical_services,
    };
  }
}
