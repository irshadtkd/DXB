import 'package:get_it/get_it.dart';

import '../../data/core/mock_asset_client.dart';
import '../../data/repositories/mock_app_repositories.dart';
import '../../domain/repositories/app_repositories.dart';
import '../../domain/usecases/usecases.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerLazySingleton<MockAssetClient>(MockAssetClient.new);

  sl.registerLazySingleton<HubRepository>(() => HubRepositoryImpl(sl()));
  sl.registerLazySingleton<FoodRepository>(() => FoodRepositoryImpl(sl()));
  sl.registerLazySingleton<LaundryRepository>(() => LaundryRepositoryImpl(sl()));
  sl.registerLazySingleton<CarRepository>(() => CarRepositoryImpl(sl()));
  sl.registerLazySingleton<TrackingRepository>(() => TrackingRepositoryImpl(sl()));
  sl.registerLazySingleton<CheckoutRepository>(() => CheckoutRepositoryImpl(sl()));
  sl.registerLazySingleton<OrdersRepository>(() => OrdersRepositoryImpl(sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton<HomeServicesRepository>(() => HomeServicesRepositoryImpl(sl()));
  sl.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl(sl()));
  sl.registerLazySingleton<NotificationsRepository>(() => NotificationsRepositoryImpl(sl()));
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));
  sl.registerLazySingleton<SupportRepository>(() => SupportRepositoryImpl(sl()));

  sl.registerFactory(() => GetHubSummary(sl()));
  sl.registerFactory(() => GetFoodHome(sl()));
  sl.registerFactory(() => GetLaundryHome(sl()));
  sl.registerFactory(() => GetLaundrySchedule(sl()));
  sl.registerFactory(() => GetLaundryOrderSummary(sl()));
  sl.registerFactory(() => GetLaundryTracking(sl()));
  sl.registerFactory(() => GetVehicles(sl()));
  sl.registerFactory(() => GetCarBooking(sl()));
  sl.registerFactory(() => GetLiveTracking(sl()));
  sl.registerFactory(() => GetCheckout(sl()));
  sl.registerFactory(() => GetOrderHistory(sl()));
  sl.registerFactory(() => GetUserProfile(sl()));
  sl.registerFactory(() => GetHomeServices(sl()));
  sl.registerFactory(() => GetWallet(sl()));
  sl.registerFactory(() => GetNotifications(sl()));
  sl.registerFactory(() => GetChatThread(sl()));
  sl.registerFactory(() => GetHelpSupport(sl()));
}
