import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../earnings/presentation/earnings_cubit.dart';

class EarningsPage extends StatelessWidget {
  const EarningsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EarningsCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.earningsTitle)),
        body: BlocConsumer<EarningsCubit, EarningsState>(
          listener: (c, s) {
            if (s is EarningsFailure) showAppErrorBanner(c, s.failure.message);
          },
          builder: (c, s) {
            if (s is EarningsLoading || s is EarningsInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (s is EarningsFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: s.failure.message, onRetry: () => c.read<EarningsCubit>().load());
            }
            final d = (s as EarningsLoaded).data;
            final fmt = NumberFormat.simpleCurrency(name: d['currency'] as String? ?? 'INR');
            final total = (d['periodTotal'] as num?)?.toDouble() ?? 0;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.dashTodayRevenue, style: AppTextStyles.dmSans(color: AppColors.textSecondary)),
                      Text(fmt.format(total), style: AppTextStyles.sora(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.primary)),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
