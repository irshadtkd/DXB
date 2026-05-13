import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import 'earnings_cubit.dart';

class PayoutsPage extends StatelessWidget {
  const PayoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PayoutsCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.payoutsTitle)),
        body: BlocConsumer<PayoutsCubit, PayoutsState>(
          listener: (c, s) {
            if (s is PayoutsFailure) showAppErrorBanner(c, s.failure.message);
          },
          builder: (c, s) {
            if (s is PayoutsLoading || s is PayoutsInitial) {
              return ListView.builder(itemCount: 5, itemBuilder: (_, __) => const ShimmerListTile());
            }
            if (s is PayoutsFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: s.failure.message, onRetry: () => c.read<PayoutsCubit>().load());
            }
            final items = (s as PayoutsLoaded).items;
            if (items.isEmpty) {
              return AppEmptyState(title: AppStrings.emptyTitle, subtitle: AppStrings.emptySubtitle, onRetry: () => c.read<PayoutsCubit>().load());
            }
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (c, i) {
                final p = items[i] as Map<String, dynamic>;
                return ListTile(
                  title: Text(p['date'] as String? ?? ''),
                  subtitle: Text(p['method'] as String? ?? ''),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('₹${p['amount']}', style: AppTextStyles.dmSans(fontWeight: FontWeight.w700)),
                      AppBadge(label: p['status'] as String? ?? '', variant: AppBadgeVariant.muted),
                    ],
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
