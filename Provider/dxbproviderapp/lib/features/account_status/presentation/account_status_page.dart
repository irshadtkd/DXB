import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../session/domain/account_status.dart';
import '../../session/presentation/session_cubit.dart';

class AccountStatusPage extends StatelessWidget {
  const AccountStatusPage({super.key, required this.status});

  final AccountStatus status;

  @override
  Widget build(BuildContext context) {
    final (title, body, color) = switch (status) {
      AccountStatus.pendingApproval => (AppStrings.statusPendingTitle, AppStrings.statusPendingBody, AppColors.primary),
      AccountStatus.rejected => (AppStrings.statusRejectedTitle, AppStrings.statusRejectedBody, AppColors.error),
      AccountStatus.suspended => (AppStrings.statusSuspendedTitle, AppStrings.statusSuspendedBody, AppColors.warning),
      _ => (AppStrings.statusPendingTitle, AppStrings.statusPendingBody, AppColors.primary),
    };

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Icon(Icons.info_outline, size: 56, color: color),
              const SizedBox(height: 20),
              Text(title, style: AppTextStyles.sora(fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              Text(body, style: AppTextStyles.dmSans(fontSize: 14, color: AppColors.textSecondary, height: 1.5)),
              const Spacer(),
              AppPrimaryButton(
                label: AppStrings.contactSupport,
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              if (status == AccountStatus.rejected || status == AccountStatus.suspended)
                AppOutlineButton(
                  label: AppStrings.resubmit,
                  onPressed: () async {
                    await context.read<SessionCubit>().markApproved();
                    if (context.mounted) context.go('/register/documents');
                  },
                ),
              if (status == AccountStatus.pendingApproval)
                AppOutlineButton(
                  label: AppStrings.goHome,
                  onPressed: () async {
                    await context.read<SessionCubit>().markApproved();
                    if (context.mounted) context.go('/home');
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
