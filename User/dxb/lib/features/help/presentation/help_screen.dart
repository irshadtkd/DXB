import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_safe_body.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import 'cubit/help_cubit.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HelpCubit(sl())..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.helpTitle),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<HelpCubit, HelpState>(
            builder: (context, state) {
            if (state.status != LoadStatus.success) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(AppStrings.helpFaq, style: AppTextStyles.displayMd()),
                const SizedBox(height: 8),
                ...state.faqs.map((f) => ExpansionTile(
                      title: Text(f.question, style: AppTextStyles.bodyMd(weight: FontWeight.w600)),
                      children: [Padding(padding: const EdgeInsets.all(16), child: Text(f.answer, style: AppTextStyles.bodyMd(color: AppColors.onSurface2)))],
                    )),
                const SizedBox(height: 24),
                Text(AppStrings.helpContact, style: AppTextStyles.displayMd()),
                ...state.contacts.map((c) => ListTile(
                      title: Text(c.label, style: AppTextStyles.bodyMd(weight: FontWeight.w600)),
                      subtitle: Text(c.value, style: AppTextStyles.bodySm(color: AppColors.primary)),
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
