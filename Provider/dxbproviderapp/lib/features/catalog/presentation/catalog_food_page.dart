import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import '../data/catalog_repository.dart';
import 'catalog_vertical_cubit.dart';

class CatalogFoodPage extends StatelessWidget {
  const CatalogFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CatalogVerticalCubit>()..load(CatalogVertical.food),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.catalogFoodTitle)),
        body: BlocConsumer<CatalogVerticalCubit, CatalogVerticalState>(
          listener: (context, state) {
            if (state is CatalogVerticalFailure) showAppErrorBanner(context, state.failure.message);
          },
          builder: (context, state) {
            if (state is CatalogVerticalLoading || state is CatalogVerticalInitial) {
              return ListView.builder(itemCount: 6, itemBuilder: (_, __) => const ShimmerListTile());
            }
            if (state is CatalogVerticalFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: state.failure.message, onRetry: () => context.read<CatalogVerticalCubit>().load(CatalogVertical.food));
            }
            final items = (state as CatalogVerticalLoaded).data['items'] as List<dynamic>? ?? [];
            if (items.isEmpty) {
              return AppEmptyState(title: AppStrings.emptyTitle, subtitle: AppStrings.emptySubtitle, onRetry: () => context.read<CatalogVerticalCubit>().load(CatalogVertical.food));
            }
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (c, i) {
                final m = items[i] as Map<String, dynamic>;
                return ListTile(
                  title: Text(m['name'] as String? ?? ''),
                  subtitle: Text('₹${m['price']}'),
                  trailing: Switch(value: m['active'] as bool? ?? false, onChanged: (_) {}),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
