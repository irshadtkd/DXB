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
import 'cubit/hs_cubit.dart';

class HsBookScreen extends StatelessWidget {
  const HsBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HsCubit(sl())..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.hsBookService),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<HsCubit, HsState>(
            builder: (context, state) {
            if (state.status != LoadStatus.success || state.bundle == null) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            final b = state.bundle!;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(AppStrings.hsPickSlot, style: AppTextStyles.displayMd()),
                const SizedBox(height: 12),
                ...b.bookSlots.map((s) => ListTile(
                      title: Text(s.label),
                      enabled: s.available,
                      trailing: s.available ? const Icon(Icons.chevron_right) : Text(AppStrings.commonUnavailable, style: AppTextStyles.bodySm()),
                    )),
                const SizedBox(height: 24),
                MsPrimaryButton(
                  label: AppStrings.hsBookService,
                  onPressed: () => context.push(RoutePaths.homeServiceTrack('HS-4412')),
                ),
              ],
            );
            },
          ),
        ),
      ),
    );
  }
}
