import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import 'customers_list_cubit.dart';

class CustomersListPage extends StatelessWidget {
  const CustomersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CustomersListCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.customersTitle)),
        body: BlocConsumer<CustomersListCubit, CustomersListState>(
          listener: (context, state) {
            if (state is CustomersListFailure) showAppErrorBanner(context, state.failure.message);
          },
          builder: (context, state) {
            if (state is CustomersListLoading || state is CustomersListInitial) {
              return ListView.builder(itemCount: 6, itemBuilder: (_, __) => const ShimmerListTile());
            }
            if (state is CustomersListFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: state.failure.message, onRetry: () => context.read<CustomersListCubit>().load());
            }
            if (state is CustomersListEmpty) {
              return AppEmptyState(title: AppStrings.emptyTitle, subtitle: AppStrings.emptySubtitle, onRetry: () => context.read<CustomersListCubit>().load());
            }
            final items = (state as CustomersListLoaded).items;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (c, i) {
                final m = items[i] as Map<String, dynamic>;
                return ListTile(
                  leading: CircleAvatar(child: Text((m['name'] as String? ?? '?')[0])),
                  title: Text(m['name'] as String? ?? ''),
                  subtitle: Text(m['email'] as String? ?? ''),
                  trailing: Text('${m['orders']}', style: AppTextStyles.dmSans(fontSize: 12, color: AppColors.textMuted)),
                  onTap: () => context.push('/home/customers/${m['id']}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
