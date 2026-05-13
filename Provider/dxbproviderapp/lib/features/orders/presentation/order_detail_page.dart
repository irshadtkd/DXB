import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import 'order_detail_cubit.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OrderDetailCubit>()..load(orderId),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.orderDetailTitle)),
        body: BlocConsumer<OrderDetailCubit, OrderDetailState>(
          listener: (context, state) {
            if (state is OrderDetailFailure) {
              showAppErrorBanner(context, state.failure.message);
            }
          },
          builder: (context, state) {
            if (state is OrderDetailLoading || state is OrderDetailInitial) {
              return const Padding(padding: EdgeInsets.all(16), child: ShimmerBox(height: 200));
            }
            if (state is OrderDetailFailure) {
              return AppEmptyState(
                title: AppStrings.errorTitle,
                subtitle: state.failure.message,
                onRetry: () => context.read<OrderDetailCubit>().load(orderId),
              );
            }
            final d = (state as OrderDetailLoaded).data;
            final items = d['items'] as List<dynamic>? ?? [];
            final timeline = d['timeline'] as List<dynamic>? ?? [];
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${AppStrings.orderCustomer}: ${(d['customer'] as Map?)?['name'] ?? ''}', style: AppTextStyles.dmSans(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      Text('${d['code']}', style: AppTextStyles.dmSans(color: AppColors.textMuted)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(AppStrings.orderItems, style: AppTextStyles.sora(fontWeight: FontWeight.w700)),
                ...items.map((e) {
                  final m = e as Map<String, dynamic>;
                  return ListTile(
                    title: Text(m['name'] as String? ?? ''),
                    subtitle: Text('x${m['qty']}'),
                    trailing: Text('₹${m['price']}', style: AppTextStyles.dmSans(fontWeight: FontWeight.w600)),
                  );
                }),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.orderTotal, style: AppTextStyles.sora(fontWeight: FontWeight.w800)),
                    Text('₹${d['total']}', style: AppTextStyles.sora(fontWeight: FontWeight.w800, color: AppColors.primary)),
                  ],
                ),
                const SizedBox(height: 16),
                Text(AppStrings.orderTimeline, style: AppTextStyles.sora(fontWeight: FontWeight.w700)),
                ...timeline.map((e) {
                  final m = e as Map<String, dynamic>;
                  return ListTile(
                    dense: true,
                    leading: const Icon(Icons.circle, size: 8, color: AppColors.primary),
                    title: Text(m['label'] as String? ?? ''),
                    trailing: Text(m['time'] as String? ?? '', style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textMuted)),
                  );
                }),
                const SizedBox(height: 16),
                AppPrimaryButton(
                  label: AppStrings.orderStatusUpdate,
                  onPressed: () => _showStatusSheet(context, d),
                ),
                const SizedBox(height: 10),
                AppOutlineButton(
                  label: AppStrings.orderProofUpload,
                  onPressed: () => context.push('/orders/$orderId/proof'),
                ),
                const SizedBox(height: 10),
                AppOutlineButton(
                  label: AppStrings.orderAssignRider,
                  onPressed: () => context.push('/orders/$orderId/rider'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

void _showStatusSheet(BuildContext context, Map<String, dynamic> d) {
  final allowed = (d['allowedStatuses'] as List<dynamic>?)?.cast<String>() ?? [];
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppStrings.orderSelectStatus, style: AppTextStyles.sora(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            ...allowed.map(
              (s) => ListTile(
                title: Text(s),
                onTap: () {
                  Navigator.pop(ctx);
                  showAppSnack(context, s);
                },
              ),
            ),
            AppPrimaryButton(label: AppStrings.orderConfirmStatus, onPressed: () => Navigator.pop(ctx)),
          ],
        ),
      );
    },
  );
}
