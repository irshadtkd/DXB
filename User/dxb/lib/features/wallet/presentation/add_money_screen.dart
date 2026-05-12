import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../common/widgets/ms_primary_button.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import 'cubit/wallet_cubit.dart';

class AddMoneyScreen extends StatelessWidget {
  const AddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WalletCubit(sl())..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.walletAddMoney),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
            if (state.status != LoadStatus.success || state.data == null) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            final amounts = state.data!.quickAmounts;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppStrings.walletQuickAdd, style: AppTextStyles.displayMd()),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: amounts
                        .map((a) => ActionChip(
                              label: Text('₹$a'),
                              onPressed: () {},
                            ))
                        .toList(),
                  ),
                  const Spacer(),
                  MsPrimaryButton(label: AppStrings.walletAddMoney, onPressed: () => context.pop()),
                ],
              ),
            );
            },
          ),
        ),
      ),
    );
  }
}
