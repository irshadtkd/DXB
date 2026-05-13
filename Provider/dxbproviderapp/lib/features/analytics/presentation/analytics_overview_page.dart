import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../analytics/presentation/analytics_cubit.dart';

class AnalyticsOverviewPage extends StatelessWidget {
  const AnalyticsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AnalyticsOverviewCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.analyticsOverviewTitle)),
        body: BlocConsumer<AnalyticsOverviewCubit, AnalyticsOverviewState>(
          listener: (c, s) {
            if (s is AnalyticsOverviewFailure) showAppErrorBanner(c, s.failure.message);
          },
          builder: (c, s) {
            if (s is AnalyticsOverviewLoading || s is AnalyticsOverviewInitial) {
              return ListView.builder(itemCount: 5, itemBuilder: (_, __) => const ShimmerListTile());
            }
            if (s is AnalyticsOverviewFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: s.failure.message, onRetry: () => c.read<AnalyticsOverviewCubit>().load());
            }
            final d = (s as AnalyticsOverviewLoaded).data;
            final kpis = d['kpis'] as List<dynamic>? ?? [];
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...kpis.map((e) {
                  final m = e as Map<String, dynamic>;
                  return AppCard(
                    child: ListTile(
                      title: Text(m['label'] as String? ?? ''),
                      subtitle: Text(m['delta'] as String? ?? '', style: AppTextStyles.dmSans(color: AppColors.success)),
                      trailing: Text(m['value'] as String? ?? '', style: AppTextStyles.sora(fontWeight: FontWeight.w800)),
                    ),
                  );
                }),
                TextButton(onPressed: () => context.push('/account/analytics/vertical'), child: Text(AppStrings.analyticsVerticalTitle)),
                TextButton(onPressed: () => context.push('/account/analytics/operational'), child: Text(AppStrings.analyticsOpsTitle)),
              ],
            );
          },
        ),
      ),
    );
  }
}
