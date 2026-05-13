import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import 'dashboard_cubit.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DashboardCubit>()..load(),
      child: const _DashboardBody(),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {
          if (state is DashboardFailure) {
            showAppErrorBanner(context, state.failure.message);
          }
        },
        builder: (context, state) {
          if (state is DashboardLoading || state is DashboardInitial) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _headerShimmer()),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(delegate: SliverChildBuilderDelegate((_, i) => const ShimmerListTile(), childCount: 6)),
                ),
              ],
            );
          }
          if (state is DashboardFailure) {
            return AppEmptyState(
              title: AppStrings.errorTitle,
              subtitle: state.failure.message,
              isError: true,
              onRetry: () => context.read<DashboardCubit>().load(),
            );
          }
          final data = (state as DashboardLoaded).data;
          final currency = NumberFormat.simpleCurrency(name: data['revenueCurrency'] as String? ?? 'INR');
          final revenue = (data['todayRevenue'] as num?)?.toDouble() ?? 0;
          final orders = data['todayOrders'] as int? ?? 0;
          final completion = data['completionPct'] as int? ?? 0;
          final rating = data['rating'] as num? ?? 0;
          final sla = data['slaAlert'] as Map<String, dynamic>?;
          final alerts = data['alerts'] as List<dynamic>? ?? [];
          final recent = data['recentOrders'] as List<dynamic>? ?? [];
          final bars = data['weeklyBars'] as List<dynamic>? ?? [];

          return RefreshIndicator(
            onRefresh: () => context.read<DashboardCubit>().load(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: _DashHeader(revenue: revenue, currency: currency, businessName: data['businessName'] as String? ?? '')),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(child: _KpiCard(value: '$orders', label: AppStrings.dashKpiOrders, color: AppColors.primary)),
                        const SizedBox(width: 8),
                        Expanded(child: _KpiCard(value: '$completion%', label: AppStrings.dashKpiCompletion, color: AppColors.success)),
                        const SizedBox(width: 8),
                        Expanded(child: _KpiCard(value: '$rating⭐', label: AppStrings.dashKpiRating, color: AppColors.accent)),
                      ],
                    ),
                  ),
                ),
                if (sla != null)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(child: _SlaCard(sla: sla)),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: AppSectionHeader(
                      title: AppStrings.dashAlertsTasks,
                      trailing: AppBadge(label: '${alerts.length} ${AppStrings.dashPendingCount}', variant: AppBadgeVariant.primary),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (c, i) {
                        final a = alerts[i] as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _AlertTile(map: a),
                        );
                      },
                      childCount: alerts.length,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  sliver: SliverToBoxAdapter(child: AppSectionHeader(title: AppStrings.dashQuickActions)),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverToBoxAdapter(child: const _QuickActions()),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: AppSectionHeader(
                      title: AppStrings.dashRecentOrders,
                      trailing: TextButton(onPressed: () => context.go('/orders'), child: const Text(AppStrings.seeAll)),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (c, i) {
                        final o = recent[i] as Map<String, dynamic>;
                        return _MiniOrderTile(
                          map: o,
                          onTap: () => context.go('/orders/${o["id"]}'),
                        );
                      },
                      childCount: recent.length,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(child: _WeeklyChart(bars: bars.cast<num>())),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 88)),
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget _headerShimmer() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ShimmerBox(height: 14, width: 120),
          SizedBox(height: 8),
          ShimmerBox(height: 22, width: 200),
          SizedBox(height: 16),
          ShimmerBox(height: 100),
        ],
      ),
    );
  }
}

class _DashHeader extends StatelessWidget {
  const _DashHeader({required this.revenue, required this.currency, required this.businessName});

  final double revenue;
  final NumberFormat currency;
  final String businessName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryLight]),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.dashGoodMorning, style: AppTextStyles.dmSans(fontSize: 13, color: const Color(0xE6FFFFFF))),
                    Text(businessName, style: AppTextStyles.sora(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.dashTodayRevenue, style: AppTextStyles.dmSans(fontSize: 12, color: const Color(0xCCFFFFFF))),
                Text(currency.format(revenue), style: AppTextStyles.sora(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white)),
                Text('↑ 18% ${AppStrings.dashVsYesterday}', style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.accentLight)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.value, required this.label, required this.color});

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: AppTextStyles.sora(fontSize: 20, fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.dmSans(fontSize: 11, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _SlaCard extends StatelessWidget {
  const _SlaCard({required this.sla});

  final Map<String, dynamic> sla;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppColors.error),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sla['title'] as String? ?? '', style: AppTextStyles.dmSans(fontWeight: FontWeight.w700)),
                Text(sla['subtitle'] as String? ?? '', style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Text(sla['timer'] as String? ?? '', style: AppTextStyles.sora(fontWeight: FontWeight.w700, color: AppColors.primary)),
        ],
      ),
    );
  }
}

class _AlertTile extends StatelessWidget {
  const _AlertTile({required this.map});

  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    final err = map['isError'] as bool? ?? false;
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(err ? Icons.error_outline : Icons.flash_on, color: err ? AppColors.error : AppColors.accent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(map['title'] as String? ?? '', style: AppTextStyles.dmSans(fontWeight: FontWeight.w700)),
                Text(map['message'] as String? ?? '', style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _Qa(icon: Icons.add, label: AppStrings.qaAddItem, onTap: () => context.go('/catalog/food'))),
        Expanded(child: _Qa(icon: Icons.inventory_2, label: AppStrings.qaViewOrders, onTap: () => context.go('/orders'))),
        Expanded(child: _Qa(icon: Icons.payments_outlined, label: AppStrings.qaEarnings, onTap: () => context.go('/account/earnings'))),
        Expanded(child: _Qa(icon: Icons.bar_chart, label: AppStrings.qaReports, onTap: () => context.go('/account/analytics/overview'))),
      ],
    );
  }
}

class _Qa extends StatelessWidget {
  const _Qa({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            CircleAvatar(backgroundColor: AppColors.bg, child: Icon(icon, color: AppColors.primary, size: 20)),
            const SizedBox(height: 6),
            Text(label, textAlign: TextAlign.center, style: AppTextStyles.dmSans(fontSize: 10, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _MiniOrderTile extends StatelessWidget {
  const _MiniOrderTile({required this.map, required this.onTap});

  final Map<String, dynamic> map;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final status = (map['status'] as String?) ?? '';
    final badge = status == 'delivered' ? AppBadgeVariant.success : AppBadgeVariant.warning;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AppCard(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const CircleAvatar(child: Icon(Icons.restaurant)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(map['title'] as String? ?? '', style: AppTextStyles.dmSans(fontWeight: FontWeight.w700)),
                    Text(map['subtitle'] as String? ?? '', style: AppTextStyles.dmSans(fontSize: 11, color: AppColors.textMuted)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('₹${map['amount']}', style: AppTextStyles.dmSans(fontWeight: FontWeight.w700)),
                  AppBadge(label: status, variant: badge),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeeklyChart extends StatelessWidget {
  const _WeeklyChart({required this.bars});

  final List<num> bars;

  @override
  Widget build(BuildContext context) {
    final labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.dashWeeklyEarnings, style: AppTextStyles.sora(fontWeight: FontWeight.w700)),
              Text(AppStrings.dashThisWeek, style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textMuted)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(bars.length, (i) {
                final h = (bars[i].toDouble()).clamp(0.08, 1.0);
                final accent = i == 5;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: FractionallySizedBox(
                              heightFactor: h,
                              widthFactor: 1,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: accent ? AppColors.accent : AppColors.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(labels[i], style: AppTextStyles.dmSans(fontSize: 10, color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
