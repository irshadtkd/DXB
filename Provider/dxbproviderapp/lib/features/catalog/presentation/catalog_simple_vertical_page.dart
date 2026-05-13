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

class CatalogSimpleVerticalPage extends StatelessWidget {
  const CatalogSimpleVerticalPage({super.key, required this.verticalKey});

  final String verticalKey;

  CatalogVertical get _v {
    switch (verticalKey) {
      case 'availability':
        return CatalogVertical.availability;
      case 'laundry':
        return CatalogVertical.laundry;
      case 'cars':
        return CatalogVertical.cars;
      case 'hotels':
        return CatalogVertical.hotels;
      case 'marketplace':
        return CatalogVertical.marketplace;
      case 'home_services':
        return CatalogVertical.homeServices;
      default:
        return CatalogVertical.food;
    }
  }

  String get _title {
    switch (verticalKey) {
      case 'availability':
        return AppStrings.catalogAvailabilityTitle;
      case 'laundry':
        return AppStrings.catalogLaundryTitle;
      case 'cars':
        return AppStrings.catalogCarsTitle;
      case 'hotels':
        return AppStrings.catalogHotelsTitle;
      case 'marketplace':
        return AppStrings.catalogMarketTitle;
      case 'home_services':
        return AppStrings.catalogHomeSvcTitle;
      default:
        return AppStrings.catalogFoodTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final v = _v;
    return BlocProvider(
      create: (_) => sl<CatalogVerticalCubit>()..load(v),
      child: Scaffold(
        appBar: AppBar(title: Text(_title)),
        body: BlocConsumer<CatalogVerticalCubit, CatalogVerticalState>(
          listener: (context, state) {
            if (state is CatalogVerticalFailure) showAppErrorBanner(context, state.failure.message);
          },
          builder: (context, state) {
            if (state is CatalogVerticalLoading || state is CatalogVerticalInitial) {
              return ListView.builder(itemCount: 5, itemBuilder: (_, __) => const ShimmerListTile());
            }
            if (state is CatalogVerticalFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: state.failure.message, onRetry: () => context.read<CatalogVerticalCubit>().load(v));
            }
            final data = (state as CatalogVerticalLoaded).data;
            final key = _listKey(data);
            final list = (key.isEmpty ? <dynamic>[] : data[key] as List<dynamic>?) ?? [];
            if (list.isEmpty) {
              return AppEmptyState(title: AppStrings.emptyTitle, subtitle: AppStrings.emptySubtitle, onRetry: () => context.read<CatalogVerticalCubit>().load(v));
            }
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (c, i) {
                final row = list[i] as Map<String, dynamic>;
                return AppCard(
                  child: ListTile(
                    title: Text(_rowTitle(row), style: AppTextStyles.dmSans(fontWeight: FontWeight.w700)),
                    subtitle: Text(_rowSubtitle(row), style: AppTextStyles.dmSans(fontSize: 11, color: AppColors.textMuted)),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

String _listKey(Map<String, dynamic> data) {
  for (final k in ['items', 'windows', 'services', 'fleet', 'rooms', 'skus', 'jobs']) {
    if (data[k] is List) return k;
  }
  try {
    return data.keys.firstWhere((k) => data[k] is List);
  } catch (_) {
    return '';
  }
}

String _rowTitle(Map<String, dynamic> row) {
  return (row['name'] ?? row['label'] ?? row['model'] ?? row['title'] ?? row['id']).toString();
}

String _rowSubtitle(Map<String, dynamic> row) {
  return row.entries.where((e) => e.key != 'name' && e.key != 'id').map((e) => '${e.key}: ${e.value}').take(4).join(' · ');
}
