import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../common/widgets/ms_primary_button.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import 'cubit/wallet_cubit.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WalletCubit(sl())..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.walletTitle),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
            if (state.status != LoadStatus.success || state.data == null) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            final d = state.data!;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(AppStrings.walletBalance, style: AppTextStyles.displayXs(color: AppColors.onSurface3)),
                Text(d.balance, style: AppTextStyles.displayHero(color: AppColors.primary)),
                const SizedBox(height: 16),
                MsPrimaryButton(
                  label: AppStrings.walletAddMoney,
                  onPressed: () => context.push(RoutePaths.walletAdd),
                ),
                const SizedBox(height: 24),
                Text(AppStrings.walletRecent, style: AppTextStyles.displayMd()),
                ...d.transactions.map((t) => ListTile(
                      title: Text(t.title, style: AppTextStyles.bodyMd(weight: FontWeight.w600)),
                      subtitle: Text(t.date, style: AppTextStyles.bodySm()),
                      trailing: Text(t.amount, style: AppTextStyles.displaySm(color: t.type == 'credit' ? AppColors.sage : AppColors.error, weight: FontWeight.w800)),
                    )),
              ],
            );
            },
          ),
        ),
      ),
    );
  }
}
