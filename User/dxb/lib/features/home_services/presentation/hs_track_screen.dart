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

class HsTrackScreen extends StatelessWidget {
  const HsTrackScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HsCubit(sl())..load(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: MsAppBar(title: AppStrings.hsProviderTracking),
        body: MsSafeBody(
          top: false,
          child: BlocBuilder<HsCubit, HsState>(
            builder: (context, state) {
            if (state.status != LoadStatus.success || state.bundle == null) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            final b = state.bundle!;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(b.providerName, style: AppTextStyles.displayLg()),
                  Text(b.providerRole, style: AppTextStyles.bodySm(color: AppColors.onSurface3)),
                  Text('ETA ${b.providerEta}', style: AppTextStyles.displaySm(color: AppColors.primary, weight: FontWeight.w800)),
                  Text(b.providerPhone, style: AppTextStyles.bodyMd()),
                  const Spacer(),
                  MsPrimaryButton(
                    label: AppStrings.hsCompletion,
                    onPressed: () => context.push(RoutePaths.homeServiceComplete(orderId)),
                  ),
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
