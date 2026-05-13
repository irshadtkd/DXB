import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import 'customer_detail_cubit.dart';

class CustomerDetailPage extends StatelessWidget {
  const CustomerDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CustomerDetailCubit>()..load(id),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.customerDetailTitle)),
        body: BlocConsumer<CustomerDetailCubit, CustomerDetailState>(
          listener: (context, state) {
            if (state is CustomerDetailFailure) showAppErrorBanner(context, state.failure.message);
          },
          builder: (context, state) {
            if (state is CustomerDetailLoading || state is CustomerDetailInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CustomerDetailFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: state.failure.message, onRetry: () => context.read<CustomerDetailCubit>().load(id));
            }
            if (state is CustomerDetailEmpty) {
              return AppEmptyState(title: AppStrings.emptyTitle, subtitle: AppStrings.emptySubtitle, onRetry: () => context.read<CustomerDetailCubit>().load(id));
            }
            final d = (state as CustomerDetailLoaded).data;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(d['name'] as String? ?? '', style: AppTextStyles.sora(fontSize: 22, fontWeight: FontWeight.w800)),
                Text(d['email'] as String? ?? '', style: AppTextStyles.dmSans(color: AppColors.textSecondary)),
                const SizedBox(height: 16),
                AppCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _customerStat(AppStrings.customerOrders, '${d['orders']}'),
                      _customerStat(AppStrings.customerSpend, '₹${d['spend']}'),
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
}

Widget _customerStat(String l, String v) => Column(
      children: [
        Text(v, style: AppTextStyles.sora(fontWeight: FontWeight.w800)),
        Text(l, style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textMuted)),
      ],
    );
