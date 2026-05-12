import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../common/widgets/ms_card.dart';
import '../../../common/widgets/ms_error_state.dart';
import '../../../common/widgets/ms_loader.dart';
import '../../../common/widgets/ms_primary_button.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import 'cubit/laundry_home_cubit.dart';

class LaundryHomeScreen extends StatelessWidget {
  const LaundryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LaundryHomeCubit(sl())..load(),
      child: BlocBuilder<LaundryHomeCubit, LaundryHomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.surface,
            appBar: MsAppBar(
              title: AppStrings.laundryTitle,
              actions: [
                Stack(
                  children: [
                    IconButton(
                      onPressed: () => context.push(RoutePaths.notifications),
                      icon: const Icon(Icons.notifications_none),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            body: MsSafeBody(
              top: false,
              child: _laundryHomeBody(context, state),
            ),
          );
        },
      ),
    );
  }
}

Widget _laundryHomeBody(BuildContext context, LaundryHomeState state) {
  if (state.status == LoadStatus.loading) return const MsLoader();
  if (state.status == LoadStatus.failure) {
    return MsErrorState(message: state.message ?? '', onRetry: () => context.read<LaundryHomeCubit>().retry());
  }
  final d = state.data!;
  return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(20),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [AppColors.sage, Color(0xFF2D6349)]),
                          borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
                        ),
                        child: Stack(
                          children: [
                            Positioned(right: -10, top: -20, child: Text('🧺', style: TextStyle(fontSize: 110, color: Colors.white.withValues(alpha: 0.12)))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(99)),
                                  child: Text(d.heroTag, style: AppTextStyles.displayXs(color: Colors.white)),
                                ),
                                const SizedBox(height: 8),
                                Text(d.heroTitle, style: AppTextStyles.displayLg(color: Colors.white)),
                                const SizedBox(height: 6),
                                Text(d.heroSubtitle, style: AppTextStyles.bodySm(color: Colors.white.withValues(alpha: 0.8))),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FilledButton(
                                        onPressed: () => context.push(RoutePaths.laundrySchedule),
                                        style: FilledButton.styleFrom(
                                          backgroundColor: AppColors.accent,
                                          foregroundColor: AppColors.onSurface,
                                          shape: const StadiumBorder(),
                                        ),
                                        child: Text(d.heroCta, style: AppTextStyles.bodySm(weight: FontWeight.w700)),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(child: Text(d.heroRating, style: AppTextStyles.bodySm(color: Colors.white.withValues(alpha: 0.75)))),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppStrings.laundryServices, style: AppTextStyles.displayMd()),
                          Text(AppStrings.laundryPriceList, style: AppTextStyles.bodyMd(color: AppColors.primary, weight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.15,
                        children: d.services.map((s) {
                          return MsCard(
                            border: s.popular
                                ? Border.all(color: AppColors.sage, width: 2)
                                : s.accent != null
                                    ? Border.all(color: AppColors.accent, width: 2)
                                    : null,
                            child: Stack(
                              children: [
                                if (s.popular)
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                      decoration: BoxDecoration(color: AppColors.sage, borderRadius: BorderRadius.circular(99)),
                                      child: Text('Popular', style: AppTextStyles.displayXs(color: Colors.white)),
                                    ),
                                  ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.sageLight,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(Icons.local_laundry_service, color: AppColors.sage, size: 22),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(s.title, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
                                    Text(s.priceFrom, style: AppTextStyles.bodySm()),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppStrings.laundryOffers, style: AppTextStyles.displayMd()),
                          Text(AppStrings.hubViewAll, style: AppTextStyles.bodyMd(color: AppColors.primary, weight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: d.coupons.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 10),
                          itemBuilder: (_, i) {
                            final c = d.coupons[i];
                            return Container(
                              width: 200,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                                gradient: LinearGradient(colors: c.gradient.map(_hex).toList()),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(c.title, style: AppTextStyles.displayLg(color: i == 0 ? AppColors.accent : Colors.white)),
                                  Text(c.subtitle, style: AppTextStyles.bodySm(color: Colors.white.withValues(alpha: 0.85))),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(c.code, style: AppTextStyles.displayXs(color: Colors.white)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppStrings.laundryPrevious, style: AppTextStyles.displayMd()),
                          Text(AppStrings.hubViewAll, style: AppTextStyles.bodyMd(color: AppColors.primary, weight: FontWeight.w600)),
                        ],
                      ),
                      ...d.previousOrders.map((o) => Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: MsCard(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(color: AppColors.sageLight, borderRadius: BorderRadius.circular(13)),
                                        child: const Icon(Icons.local_laundry_service, color: AppColors.sage),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(o.type, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
                                            Text(o.detail, style: AppTextStyles.bodySm()),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(o.amount, style: AppTextStyles.displaySm(color: AppColors.primary, weight: FontWeight.w800)),
                                          Container(
                                            margin: const EdgeInsets.only(top: 3),
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(color: AppColors.sageLight, borderRadius: BorderRadius.circular(99)),
                                            child: Text('✓ Delivered', style: AppTextStyles.displayXs(color: AppColors.sage)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  MsPrimaryButton(label: AppStrings.laundryReorder, onPressed: () {}),
                                ],
                              ),
                            ),
                          )),
                        ]),
                      ),
                    ),
                  ],
                );
}

Color _hex(String s) {
  final h = s.replaceAll('#', '');
  return Color(int.parse('FF$h', radix: 16));
}
