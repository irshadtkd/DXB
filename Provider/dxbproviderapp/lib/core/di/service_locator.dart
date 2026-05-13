import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../data/asset_json_loader.dart';
import '../network/api_client.dart';
import '../routing/app_router.dart';
import '../routing/router_refresh.dart';
import '../../features/session/presentation/session_cubit.dart';
import '../../features/dashboard/data/dashboard_repository.dart';
import '../../features/dashboard/presentation/dashboard_cubit.dart';
import '../../features/orders/data/orders_repository.dart';
import '../../features/orders/presentation/orders_list_cubit.dart';
import '../../features/orders/presentation/order_detail_cubit.dart';
import '../../features/customers/data/customers_repository.dart';
import '../../features/customers/presentation/customers_list_cubit.dart';
import '../../features/customers/presentation/customer_detail_cubit.dart';
import '../../features/inbox/data/inbox_repository.dart';
import '../../features/inbox/presentation/inbox_cubit.dart';
import '../../features/inbox/presentation/chat_cubit.dart';
import '../../features/catalog/data/catalog_repository.dart';
import '../../features/catalog/presentation/catalog_hub_cubit.dart';
import '../../features/catalog/presentation/catalog_vertical_cubit.dart';
import '../../features/earnings/data/earnings_repository.dart';
import '../../features/earnings/presentation/earnings_cubit.dart';
import '../../features/analytics/data/analytics_repository.dart';
import '../../features/analytics/presentation/analytics_cubit.dart';
import '../../features/reviews/data/reviews_repository.dart';
import '../../features/reviews/presentation/reviews_list_cubit.dart';
import '../../features/reviews/presentation/review_detail_cubit.dart';
import '../../features/settings/data/settings_repository.dart';
import '../../features/settings/presentation/settings_cubits.dart';

final sl = GetIt.instance;

void configureDependencies() {
  sl.registerLazySingleton<AssetJsonLoader>(() => const AssetJsonLoader());
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  sl.registerLazySingleton<SessionCubit>(() => SessionCubit(sl(), sl()));
  sl.registerLazySingleton<RouterRefresh>(() => RouterRefresh(sl<SessionCubit>().stream));
  sl.registerLazySingleton<GoRouter>(() => createAppRouter());

  sl.registerLazySingleton<DashboardRepository>(() => DashboardRepository(sl()));
  sl.registerLazySingleton<OrdersRepository>(() => OrdersRepository(sl()));
  sl.registerLazySingleton<CustomersRepository>(() => CustomersRepository(sl()));
  sl.registerLazySingleton<InboxRepository>(() => InboxRepository(sl()));
  sl.registerLazySingleton<CatalogRepository>(() => CatalogRepository(sl()));
  sl.registerLazySingleton<EarningsRepository>(() => EarningsRepository(sl()));
  sl.registerLazySingleton<AnalyticsRepository>(() => AnalyticsRepository(sl()));
  sl.registerLazySingleton<ReviewsRepository>(() => ReviewsRepository(sl()));
  sl.registerLazySingleton<SettingsRepository>(() => SettingsRepository(sl()));

  sl.registerFactory<DashboardCubit>(() => DashboardCubit(sl()));
  sl.registerFactory<OrdersListCubit>(() => OrdersListCubit(sl()));
  sl.registerFactory<OrderDetailCubit>(() => OrderDetailCubit(sl()));
  sl.registerFactory<CustomersListCubit>(() => CustomersListCubit(sl()));
  sl.registerFactory<CustomerDetailCubit>(() => CustomerDetailCubit(sl()));
  sl.registerFactory<InboxCubit>(() => InboxCubit(sl()));
  sl.registerFactory<ChatCubit>(() => ChatCubit(sl()));
  sl.registerFactory<CatalogHubCubit>(() => CatalogHubCubit(sl()));
  sl.registerFactory<CatalogVerticalCubit>(() => CatalogVerticalCubit(sl()));
  sl.registerFactory<EarningsCubit>(() => EarningsCubit(sl()));
  sl.registerFactory<PayoutsCubit>(() => PayoutsCubit(sl()));
  sl.registerFactory<BankCubit>(() => BankCubit(sl()));
  sl.registerFactory<AnalyticsOverviewCubit>(() => AnalyticsOverviewCubit(sl()));
  sl.registerFactory<AnalyticsVerticalCubit>(() => AnalyticsVerticalCubit(sl()));
  sl.registerFactory<AnalyticsOperationalCubit>(() => AnalyticsOperationalCubit(sl()));
  sl.registerFactory<ReviewsListCubit>(() => ReviewsListCubit(sl()));
  sl.registerFactory<ReviewDetailCubit>(() => ReviewDetailCubit(sl()));
  sl.registerFactory<BusinessProfileCubit>(() => BusinessProfileCubit(sl()));
  sl.registerFactory<ServiceAreasCubit>(() => ServiceAreasCubit(sl()));
  sl.registerFactory<OperatingHoursCubit>(() => OperatingHoursCubit(sl()));
  sl.registerFactory<TeamRolesCubit>(() => TeamRolesCubit(sl()));
  sl.registerFactory<NotificationPrefsCubit>(() => NotificationPrefsCubit(sl()));
  sl.registerFactory<HelpCenterCubit>(() => HelpCenterCubit(sl()));
  sl.registerFactory<WebToolsCubit>(() => WebToolsCubit(sl()));
}
