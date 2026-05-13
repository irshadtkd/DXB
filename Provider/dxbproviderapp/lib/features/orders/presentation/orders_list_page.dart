import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import 'orders_list_cubit.dart';

class OrdersListPage extends StatelessWidget {
  const OrdersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OrdersListCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.ordersTitle)),
        body: BlocConsumer<OrdersListCubit, OrdersListState>(
          listener: (context, state) {
            if (state is OrdersListFailure) {
              showAppErrorBanner(context, state.failure.message);
            }
          },
          builder: (context, state) {
            if (state is OrdersListLoading || state is OrdersListInitial) {
              return ListView.builder(itemCount: 8, itemBuilder: (_, __) => const ShimmerListTile());
            }
            if (state is OrdersListFailure) {
              return AppEmptyState(
                title: AppStrings.errorTitle,
                subtitle: state.failure.message,
                isError: true,
                onRetry: () => context.read<OrdersListCubit>().load(),
              );
            }
            if (state is OrdersListEmpty) {
              return AppEmptyState(
                title: AppStrings.emptyTitle,
                subtitle: AppStrings.emptySubtitle,
                onRetry: () => context.read<OrdersListCubit>().load(),
              );
            }
            final list = (state as OrdersListLoaded).orders;
            return RefreshIndicator(
              onRefresh: () => context.read<OrdersListCubit>().load(),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (c, i) {
                  final o = list[i] as Map<String, dynamic>;
                  return ListTile(
                    tileColor: AppColors.bgCard,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    title: Text(o['title'] as String? ?? '', style: AppTextStyles.dmSans(fontWeight: FontWeight.w700)),
                    subtitle: Text('${o['customer']} · ${o['time']}', style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textMuted)),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('₹${o['amount']}', style: AppTextStyles.dmSans(fontWeight: FontWeight.w700)),
                        AppBadge(label: o['status'] as String? ?? '', variant: AppBadgeVariant.warning),
                      ],
                    ),
                    onTap: () => context.push('/orders/${o['id']}'),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
