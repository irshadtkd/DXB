import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import 'analytics_cubit.dart';

class AnalyticsOperationalPage extends StatelessWidget {
  const AnalyticsOperationalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AnalyticsOperationalCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.analyticsOpsTitle)),
        body: BlocConsumer<AnalyticsOperationalCubit, AnalyticsOperationalState>(
          listener: (c, s) {
            if (s is AnalyticsOperationalFailure) showAppErrorBanner(c, s.failure.message);
          },
          builder: (c, s) {
            if (s is AnalyticsOperationalLoading || s is AnalyticsOperationalInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (s is AnalyticsOperationalFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: s.failure.message, onRetry: () => c.read<AnalyticsOperationalCubit>().load());
            }
            final list = ((s as AnalyticsOperationalLoaded).data['metrics'] as List<dynamic>?) ?? [];
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (c, i) {
                final m = list[i] as Map<String, dynamic>;
                return ListTile(
                  title: Text(m['label'] as String? ?? ''),
                  trailing: Text(m['value'] as String? ?? '', style: AppTextStyles.sora(fontWeight: FontWeight.w700, color: AppColors.primary)),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
