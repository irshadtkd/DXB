import '../entities/entities.dart';
import '../repositories/app_repositories.dart';

class GetHubSummary {
  const GetHubSummary(this._repository);
  final HubRepository _repository;
  Future<HubSummary> call() => _repository.getHub();
}

class GetFoodHome {
  const GetFoodHome(this._repository);
  final FoodRepository _repository;
  Future<FoodHomeData> call() => _repository.getFoodHome();
}

class GetLaundryHome {
  const GetLaundryHome(this._repository);
  final LaundryRepository _repository;
  Future<LaundryHomeData> call() => _repository.getLaundryHome();
}

class GetLaundrySchedule {
  const GetLaundrySchedule(this._repository);
  final LaundryRepository _repository;
  Future<LaundryScheduleData> call() => _repository.getSchedule();
}

class GetLaundryOrderSummary {
  const GetLaundryOrderSummary(this._repository);
  final LaundryRepository _repository;
  Future<LaundryOrderSummary> call() => _repository.getOrderSummary();
}

class GetLaundryTracking {
  const GetLaundryTracking(this._repository);
  final LaundryRepository _repository;
  Future<LaundryTrackingData> call(String orderId) => _repository.getTracking(orderId);
}

class GetVehicles {
  const GetVehicles(this._repository);
  final CarRepository _repository;
  Future<List<Vehicle>> call() => _repository.getVehicles();
}

class GetCarBooking {
  const GetCarBooking(this._repository);
  final CarRepository _repository;
  Future<CarBookingData> call(String vehicleId) => _repository.getBookingDraft(vehicleId);
}

class GetLiveTracking {
  const GetLiveTracking(this._repository);
  final TrackingRepository _repository;
  Future<LiveTrackingData> call(String orderId) => _repository.getLiveTracking(orderId);
}

class GetCheckout {
  const GetCheckout(this._repository);
  final CheckoutRepository _repository;
  Future<CheckoutData> call(String orderId) => _repository.getCheckout(orderId);
}

class GetOrderHistory {
  const GetOrderHistory(this._repository);
  final OrdersRepository _repository;
  Future<List<OrderHistoryItem>> call() => _repository.getOrders();
}

class GetUserProfile {
  const GetUserProfile(this._repository);
  final UserRepository _repository;
  Future<UserProfile> call() => _repository.getProfile();
}

class GetHomeServices {
  const GetHomeServices(this._repository);
  final HomeServicesRepository _repository;
  Future<HomeServicesBundle> call() => _repository.getBundle();
}

class GetWallet {
  const GetWallet(this._repository);
  final WalletRepository _repository;
  Future<WalletData> call() => _repository.getWallet();
}

class GetNotifications {
  const GetNotifications(this._repository);
  final NotificationsRepository _repository;
  Future<List<AppNotification>> call() => _repository.getNotifications();
}

class GetChatThread {
  const GetChatThread(this._repository);
  final ChatRepository _repository;
  Future<ChatThread> call(String threadId) => _repository.getThread(threadId);
}

class GetHelpSupport {
  const GetHelpSupport(this._repository);
  final SupportRepository _repository;
  Future<({List<FaqItem> faqs, List<ContactOption> contacts})> call() => _repository.getHelp();
}
