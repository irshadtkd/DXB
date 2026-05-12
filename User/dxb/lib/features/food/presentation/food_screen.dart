import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../common/widgets/ms_card.dart';
import '../../../common/widgets/ms_error_state.dart';
import '../../../common/widgets/ms_loader.dart';
import '../../../common/widgets/ms_text_field.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import '../../../domain/entities/entities.dart';
import '../../../core/di/service_locator.dart';
import 'cubit/food_cubit.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FoodCubit(sl())..load(),
      child: const _FoodView(),
    );
  }
}

class _FoodView extends StatelessWidget {
  const _FoodView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodCubit, FoodState>(
      builder: (context, state) {
        List<Widget>? appBarActions;
        if (state.status == LoadStatus.success && state.data != null) {
          final cart = state.data!.cartCount;
          appBarActions = [
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_bag_outlined),
                ),
                if (cart > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: AppColors.primary,
                      child: Text('$cart', style: AppTextStyles.displayXs(color: Colors.white)),
                    ),
                  ),
              ],
            ),
          ];
        }

        Widget bodyChild() {
          if (state.status == LoadStatus.loading) return const MsLoader();
          if (state.status == LoadStatus.failure) {
            return MsErrorState(message: state.message ?? '', onRetry: () => context.read<FoodCubit>().retry());
          }
          final d = state.data!;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.hubDeliveringTo, style: AppTextStyles.bodySm()),
                      Text(d.locationShort, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 8),
                    MsTextField(hint: AppStrings.foodSearchHint, prefixIcon: Icons.search, fillMuted: true),
                    const SizedBox(height: 14),
                    _DealBanner(data: d),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: d.categories.map((c) {
                          final active = c.id == state.selectedCategoryId;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(c.label),
                              selected: active,
                              onSelected: (_) => context.read<FoodCubit>().selectCategory(c.id),
                              selectedColor: AppColors.primary,
                              labelStyle: AppTextStyles.chip(color: active ? Colors.white : AppColors.onSurface2),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppStrings.foodPopularNearby, style: AppTextStyles.displayMd()),
                        Text(AppStrings.hubViewAll, style: AppTextStyles.bodyMd(color: AppColors.primary, weight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...d.restaurants.map((r) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: MsCard(
                            onTap: () => context.push(RoutePaths.checkout('fd-demo')),
                            padding: EdgeInsets.zero,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 130,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: r.heroGradient.map(_hexColor).toList(),
                                          ),
                                        ),
                                      ),
                                      Center(child: Text(r.heroEmoji, style: const TextStyle(fontSize: 60))),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(99)),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.star, size: 13, color: AppColors.accent),
                                              Text(' ${r.rating}', style: AppTextStyles.bodySm(color: Colors.white, weight: FontWeight.w600)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: r.badge.toLowerCase().contains('veg')
                                                ? AppColors.sage
                                                : AppColors.accent,
                                            borderRadius: BorderRadius.circular(99),
                                          ),
                                          child: Text(r.badge, style: AppTextStyles.bodySm(color: Colors.white, weight: FontWeight.w700)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(r.name, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
                                          Text(r.minOrder, style: AppTextStyles.bodySm()),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.timer, size: 13, color: AppColors.onSurface3),
                                          Text(' ${r.eta}', style: AppTextStyles.bodySm()),
                                          Text('  •  ', style: AppTextStyles.bodySm()),
                                          Icon(Icons.local_shipping, size: 13, color: r.deliveryFree ? AppColors.sage : AppColors.onSurface3),
                                          Text(
                                            ' ${r.delivery}',
                                            style: AppTextStyles.bodySm(
                                              color: r.deliveryFree ? AppColors.sage : AppColors.onSurface3,
                                              weight: r.deliveryFree ? FontWeight.w600 : FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                    const SizedBox(height: 24),
                  ]),
                ),
              ),
            ],
          );
        }

        return Scaffold(
          backgroundColor: AppColors.surface,
          appBar: MsAppBar(
            title: AppStrings.foodTitle,
            actions: appBarActions,
          ),
          body: MsSafeBody(
            top: false,
            child: bodyChild(),
          ),
        );
      },
    );
  }
}

Color _hexColor(String hex) {
  final h = hex.replaceAll('#', '');
  return Color(int.parse('FF$h', radix: 16));
}

class _DealBanner extends StatelessWidget {
  const _DealBanner({required this.data});
  final FoodHomeData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.accent, Color(0xFFE8942A)]),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.dealTitle, style: AppTextStyles.displayXs(color: Colors.white.withValues(alpha: 0.9))),
                const SizedBox(height: 4),
                Text(data.dealHeadline, style: AppTextStyles.displayLg(color: Colors.white)),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () => context.push(RoutePaths.checkout('fd-demo')),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.accentDark,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(data.dealCta, style: AppTextStyles.bodySm(weight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          const Text('🍔', style: TextStyle(fontSize: 72)),
        ],
      ),
    );
  }
}
