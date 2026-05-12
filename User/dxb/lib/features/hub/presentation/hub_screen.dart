import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_card.dart';
import '../../../common/widgets/ms_empty_state.dart';
import '../../../common/widgets/ms_error_state.dart';
import '../../../common/widgets/ms_loader.dart';
import '../../../common/widgets/ms_shimmer.dart';
import '../../../common/widgets/ms_text_field.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import '../../../domain/entities/entities.dart';
import 'cubit/hub_cubit.dart';

class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HubCubit, HubState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.surface,
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _HubTopBar(
                  locationName: state.data?.locationName,
                  onProfile: () => context.go(RoutePaths.profileTab),
                ),
              ),
              if (state.status == LoadStatus.loading)
                const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(20), child: MsCardShimmer(height: 200)))
              else if (state.status == LoadStatus.failure)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: MsErrorState(message: state.message ?? '', onRetry: () => context.read<HubCubit>().retry()),
                )
              else if (state.data == null)
                const SliverFillRemaining(hasScrollBody: false, child: MsEmptyState())
              else
                _HubBody(data: state.data!),
            ],
          ),
        );
      },
    );
  }
}

class _HubTopBar extends StatelessWidget {
  const _HubTopBar({this.locationName, required this.onProfile});
  final String? locationName;
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      decoration: const BoxDecoration(
        color: AppColors.surfaceCard,
        boxShadow: [BoxShadow(color: Color(0x141C2B6B), blurRadius: 4, offset: Offset(0, 1))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: AppColors.primary),
                    const SizedBox(width: 2),
                    Text(AppStrings.hubDeliveringTo, style: AppTextStyles.bodySm()),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  locationName ?? '…',
                  style: AppTextStyles.displaySm(weight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Multi', style: AppTextStyles.displaySm(color: AppColors.primary, weight: FontWeight.w800)),
                TextSpan(text: 'Serve', style: AppTextStyles.displaySm(color: AppColors.accent, weight: FontWeight.w800)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onProfile,
            borderRadius: BorderRadius.circular(99),
            child: Container(
              width: AppDimensions.topBarAvatar,
              height: AppDimensions.topBarAvatar,
              decoration: BoxDecoration(
                color: AppColors.primaryDim,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: const Icon(Icons.person, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

class _HubBody extends StatelessWidget {
  const _HubBody({required this.data});
  final HubSummary data;

  Color _accent(String key) {
    return switch (key) {
      'amber' => AppColors.accent,
      'sage' => AppColors.sage,
      'primary' => AppColors.primary,
      'purple' => AppColors.homeServicePurple,
      _ => AppColors.primary,
    };
  }

  IconData _icon(String k) {
    return switch (k) {
      'restaurant' => Icons.restaurant,
      'laundry' => Icons.local_laundry_service,
      'car' => Icons.directions_car,
      _ => Icons.handyman,
    };
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: MsTextField(
            hint: AppStrings.hubSearchHint,
            prefixIcon: Icons.search,
            fillMuted: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: _PromoCard(data: data),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.hubOurServices, style: AppTextStyles.displayMd()),
              Text(AppStrings.hubViewAll, style: AppTextStyles.bodyMd(color: AppColors.primary, weight: FontWeight.w600)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.35,
            children: data.services.map((s) {
              final c = _accent(s.accentKey);
              return MsCard(
                onTap: () => context.push(s.route),
                border: Border(left: BorderSide(color: c, width: 4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: c.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(_icon(s.iconKey), color: c, size: 24),
                    ),
                    const SizedBox(height: 10),
                    Text(s.title, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(s.subtitle, style: AppTextStyles.bodySm()),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.hubRecentOrders, style: AppTextStyles.displayMd()),
              InkWell(
                onTap: () => context.go(RoutePaths.ordersTab),
                child: Text(AppStrings.hubHistory, style: AppTextStyles.bodyMd(color: AppColors.primary, weight: FontWeight.w600)),
              ),
            ],
          ),
        ),
        ...data.recentOrders.map((o) => Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: MsCard(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: o.type == 'food' ? AppColors.accentLight : AppColors.primaryDim,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: o.iconEmoji != null
                          ? Center(child: Text(o.iconEmoji!, style: const TextStyle(fontSize: 24)))
                          : Icon(_icon(o.iconKey ?? 'laundry'), color: AppColors.primary),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(o.title, style: AppTextStyles.displaySm(weight: FontWeight.w700)),
                          Text(o.subtitle, style: AppTextStyles.bodySm()),
                        ],
                      ),
                    ),
                    _OrderStatusChip(status: o.status),
                  ],
                ),
              ),
            )),
        const SizedBox(height: 24),
      ]),
    );
  }
}

class _OrderStatusChip extends StatelessWidget {
  const _OrderStatusChip({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final delivered = status == 'delivered';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: delivered ? AppColors.sageLight : AppColors.inProgressBg,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        delivered ? AppStrings.commonDelivered : AppStrings.commonInProgress,
        style: AppTextStyles.bodySm(
          color: delivered ? AppColors.sage : AppColors.inProgressFg,
          weight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard({required this.data});
  final HubSummary data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryLight]),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(right: -10, top: -10, child: CircleAvatar(radius: 60, backgroundColor: AppColors.accent.withValues(alpha: 0.15))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(99)),
                child: Text(
                  '🔥 ${data.promoTag}',
                  style: AppTextStyles.displayXs(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              Text(data.promoTitle, style: AppTextStyles.displayLg(color: Colors.white)),
              const SizedBox(height: 6),
              Text(
                data.promoSubtitle,
                style: AppTextStyles.bodySm(color: Colors.white.withValues(alpha: 0.7)),
              ),
              const SizedBox(height: 14),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.onSurface,
                  shape: const StadiumBorder(),
                ),
                child: Text(data.promoCta, style: AppTextStyles.bodySm(weight: FontWeight.w700)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
