import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/provider_categories.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_messenger.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../session/presentation/session_cubit.dart';
import 'catalog_hub_cubit.dart';

class CatalogHubPage extends StatelessWidget {
  const CatalogHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CatalogHubCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.catalogHubTitle)),
        body: BlocConsumer<CatalogHubCubit, CatalogHubState>(
          listener: (context, state) {
            if (state is CatalogHubFailure) showAppErrorBanner(context, state.failure.message);
          },
          builder: (context, state) {
            if (state is CatalogHubLoading || state is CatalogHubInitial) {
              return ListView.builder(itemCount: 7, itemBuilder: (_, __) => const ShimmerListTile());
            }
            if (state is CatalogHubFailure) {
              return AppEmptyState(title: AppStrings.errorTitle, subtitle: state.failure.message, onRetry: () => context.read<CatalogHubCubit>().load());
            }
            final session = context.watch<SessionCubit>().state;
            final allowedRoutes = ProviderCategoryIds.allHubRoutesFor(session.providerCategoryIds);
            final verts = (state as CatalogHubLoaded).data['verticals'] as List<dynamic>? ?? [];
            final filtered = verts.where((raw) {
              final v = raw as Map<String, dynamic>;
              final route = v['route'] as String? ?? '';
              return allowedRoutes.contains(route);
            }).toList();

            if (filtered.isEmpty) {
              return AppEmptyState(
                title: AppStrings.catalogNoSelectedServicesTitle,
                subtitle: AppStrings.catalogNoSelectedServicesBody,
                onRetry: () => context.read<CatalogHubCubit>().load(),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              itemBuilder: (c, i) {
                final v = filtered[i] as Map<String, dynamic>;
                final route = v['route'] as String? ?? '';
                return AppCard(
                  child: ListTile(
                    leading: Icon(CatalogHubPage.iconFor(route), color: AppColors.primary),
                    title: Text(v['title'] as String? ?? '', style: AppTextStyles.dmSans(fontWeight: FontWeight.w700)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/catalog/$route'),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  static IconData iconFor(String route) {
    switch (route) {
      case 'food':
        return Icons.restaurant;
      case 'availability':
        return Icons.schedule;
      case 'laundry':
        return Icons.local_laundry_service;
      case 'cars':
        return Icons.directions_car;
      case 'hotels':
        return Icons.hotel;
      case 'marketplace':
        return Icons.inventory_2;
      case 'home_services':
        return Icons.home_repair_service;
      default:
        return Icons.folder;
    }
  }
}
