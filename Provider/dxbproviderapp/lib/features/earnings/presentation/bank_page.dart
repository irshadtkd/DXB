import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import 'earnings_cubit.dart';

class BankPage extends StatelessWidget {
  const BankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BankCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.bankTitle)),
        body: BlocConsumer<BankCubit, BankState>(
          listener: (c, s) {
            if (s is BankFailure) showAppErrorBanner(c, s.failure.message);
          },
          builder: (c, s) {
            if (s is BankLoading || s is BankInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (s is BankFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: s.failure.message, onRetry: () => c.read<BankCubit>().load());
            }
            final d = (s as BankLoaded).data;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(AppStrings.bankSubtitle, style: AppTextStyles.dmSans(color: AppColors.textSecondary)),
                const SizedBox(height: 12),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BankPage.row(AppStrings.bankFieldBank, d['bankName']),
                      BankPage.row(AppStrings.bankFieldHolder, d['accountHolder']),
                      BankPage.row(AppStrings.bankFieldIban, d['iban']),
                      BankPage.row(AppStrings.bankFieldUpi, d['upiId']),
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

  static Widget row(String k, dynamic v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 100, child: Text(k, style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textMuted))),
            Expanded(child: Text('$v', style: AppTextStyles.dmSans(fontWeight: FontWeight.w600))),
          ],
        ),
      );
}
