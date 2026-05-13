import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import 'analytics_cubit.dart';

class AnalyticsVerticalPage extends StatelessWidget {
  const AnalyticsVerticalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AnalyticsVerticalCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.analyticsVerticalTitle)),
        body: BlocConsumer<AnalyticsVerticalCubit, AnalyticsVerticalState>(
          listener: (c, s) {
            if (s is AnalyticsVerticalFailure) showAppErrorBanner(c, s.failure.message);
          },
          builder: (c, s) {
            if (s is AnalyticsVerticalLoading || s is AnalyticsVerticalInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (s is AnalyticsVerticalFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: s.failure.message, onRetry: () => c.read<AnalyticsVerticalCubit>().load());
            }
            final list = ((s as AnalyticsVerticalLoaded).data['verticals'] as List<dynamic>?) ?? [];
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (c, i) {
                final m = list[i] as Map<String, dynamic>;
                return AppCard(
                  child: ListTile(
                    title: Text(m['name'] as String? ?? ''),
                    subtitle: Text('${m['sharePct']}${AppStrings.percentShare}', style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textMuted)),
                    trailing: Text('₹${m['revenue']}', style: AppTextStyles.dmSans(fontWeight: FontWeight.w700)),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
