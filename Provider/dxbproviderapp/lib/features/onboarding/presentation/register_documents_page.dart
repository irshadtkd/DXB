import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../session/domain/account_status.dart';
import '../../session/presentation/session_cubit.dart';

class RegisterDocumentsPage extends StatelessWidget {
  const RegisterDocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.registerDocsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(AppStrings.registerDocsSubtitle),
          const SizedBox(height: 16),
          AppCard(
            child: ListTile(
              leading: const Icon(Icons.upload_file_outlined),
              title: Text(AppStrings.uploadLicense),
              subtitle: Text(AppStrings.uploadTap),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: ListTile(
              leading: const Icon(Icons.badge_outlined),
              title: Text(AppStrings.uploadId),
              subtitle: Text(AppStrings.uploadTap),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 24),
          AppPrimaryButton(
            label: AppStrings.registerSubmit,
            onPressed: () async {
              await context.read<SessionCubit>().submitRegistration();
              if (context.mounted) {
                context.go('/account-status/${AccountStatus.pendingApproval.jsonName}');
              }
            },
          ),
        ],
      ),
    );
  }
}
