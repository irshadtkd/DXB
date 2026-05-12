import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/ms_app_bar.dart';
import '../../../common/widgets/ms_bottom_nav.dart';
import '../../../common/widgets/ms_card.dart';
import '../../../common/widgets/ms_error_state.dart';
import '../../../common/widgets/ms_loader.dart';
import '../../../common/widgets/ms_status_chip.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/load_status.dart';
import '../../../domain/entities/entities.dart';
import 'cubit/orders_cubit.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key, this.embeddedInShell = false});

  final bool embeddedInShell;

  @override
  Widget build(BuildContext context) {
    final body = BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state.status == LoadStatus.loading) return const MsLoader();
        if (state.status == LoadStatus.failure) {
          return MsErrorState(message: state.message ?? '', onRetry: () => context.read<OrdersCubit>().retry());
        }
        final list = context.read<OrdersCubit>().filtered;
        return Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  _FilterChip(
                    label: AppStrings.ordersAll,
                    selected: state.filter == 'all',
                    onTap: () => context.read<OrdersCubit>().setFilter('all'),
                  ),
                  _FilterChip(
                    label: AppStrings.ordersFilterFood,
                    selected: state.filter == 'food',
                    onTap: () => context.read<OrdersCubit>().setFilter('food'),
                  ),
                  _FilterChip(
                    label: AppStrings.ordersFilterLaundry,
                    selected: state.filter == 'laundry',
                    onTap: () => context.read<OrdersCubit>().setFilter('laundry'),
                  ),
                  _FilterChip(
                    label: AppStrings.ordersFilterCar,
                    selected: state.filter == 'car',
                    onTap: () => context.read<OrdersCubit>().setFilter('car'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                itemCount: list.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _OrderCard(item: list[i]),
                ),
              ),
            ),
          ],
        );
      },
    );

    final titleRow = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          if (!embeddedInShell) MsBackButton(onTap: () => context.pop()),
          Expanded(
            child: Text(
              AppStrings.ordersTitle,
              textAlign: embeddedInShell ? TextAlign.start : TextAlign.center,
              style: AppTextStyles.displayMd(),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
        ],
      ),
    );

    final shellBody = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        titleRow,
        Expanded(child: body),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.surface,
      bottomNavigationBar: embeddedInShell
          ? null
          : MsBottomNav(
              currentIndex: 1,
              onSelect: (i) {
                if (i == 0) context.go(RoutePaths.hub);
                if (i == 1) return;
                if (i == 2) context.go(RoutePaths.explore);
                if (i == 3) context.go(RoutePaths.profileTab);
              },
            ),
      body: embeddedInShell ? shellBody : SafeArea(child: shellBody),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.primary,
        labelStyle: AppTextStyles.chip(color: selected ? Colors.white : AppColors.onSurface2),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.item});
  final OrderHistoryItem item;

  MsStatusVariant _variant(String s) {
    if (s == 'delivered') return MsStatusVariant.success;
    if (s == 'cancelled') return MsStatusVariant.error;
    return MsStatusVariant.warning;
  }

  String _statusLabel(String s) {
    if (s == 'delivered') return AppStrings.commonDelivered;
    if (s == 'cancelled') return 'Cancelled';
    if (s == 'in_wash') return 'In Wash';
    return AppStrings.commonInProgress;
  }

  @override
  Widget build(BuildContext context) {
    return MsCard(
      onTap: () {},
      border: item.status == 'in_wash' ? const Border(left: BorderSide(color: AppColors.accent, width: 3)) : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: item.category == 'food' ? AppColors.accentLight : AppColors.primaryDim,
            ),
            child: item.emoji != null
                ? Center(child: Text(item.emoji!, style: const TextStyle(fontSize: 24)))
                : Icon(Icons.local_laundry_service, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(item.title, style: AppTextStyles.displaySm(weight: FontWeight.w700))),
                    Text(item.amount, style: AppTextStyles.displaySm(color: AppColors.primary, weight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(item.subtitle, style: AppTextStyles.bodySm()),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MsStatusChip(label: _statusLabel(item.status), variant: _variant(item.status)),
                    if (item.status == 'delivered')
                      TextButton(
                        onPressed: () {},
                        child: Text(AppStrings.ordersReorder),
                      )
                    else if (item.status == 'in_wash')
                      TextButton(
                        onPressed: () => context.push('${RoutePaths.laundryTracking}/${item.id}'),
                        child: Text(AppStrings.ordersTrack),
                      )
                    else if (item.ratingNote != null)
                      Text(item.ratingNote!, style: AppTextStyles.bodySm()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
