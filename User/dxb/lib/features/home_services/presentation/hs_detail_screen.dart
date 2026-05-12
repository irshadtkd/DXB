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
import '../../../domain/entities/entities.dart';
import 'cubit/hs_cubit.dart';

class HsDetailScreen extends StatelessWidget {
  const HsDetailScreen({super.key, required this.serviceId});

  final String serviceId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HsCubit(sl())..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.hsServiceDetails),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<HsCubit, HsState>(
            builder: (context, state) {
            if (state.status != LoadStatus.success || state.bundle == null) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            final b = state.bundle!;
            HomeServiceCategory svc = b.services.firstWhere((e) => e.id == serviceId, orElse: () => b.services.first);
            final isEl = serviceId == 'electrician';
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(svc.title, style: AppTextStyles.displayLg()),
                Text(svc.subtitle, style: AppTextStyles.bodyMd(color: AppColors.onSurface3)),
                const SizedBox(height: 16),
                if (isEl) ...[
                  Text(b.electricianDetailTitle, style: AppTextStyles.displaySm(weight: FontWeight.w800)),
                  Text(b.electricianDetailBody, style: AppTextStyles.bodyLg(color: AppColors.onSurface3)),
                  const SizedBox(height: 12),
                  ...b.electricianIncludes.map((x) => ListTile(leading: const Icon(Icons.check, color: AppColors.sage), title: Text(x))),
                  Text(b.electricianHourly, style: AppTextStyles.displaySm(color: AppColors.primary)),
                  Text(b.electricianVisit, style: AppTextStyles.bodySm()),
                ],
                const SizedBox(height: 24),
                MsPrimaryButton(
                  label: AppStrings.hsBookService,
                  onPressed: () => context.push(RoutePaths.homeServiceBook),
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
