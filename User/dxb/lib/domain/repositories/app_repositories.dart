import '../entities/entities.dart';

abstract class HubRepository {
  Future<HubSummary> getHub();
}

abstract class FoodRepository {
  Future<FoodHomeData> getFoodHome();
}

abstract class LaundryRepository {
  Future<LaundryHomeData> getLaundryHome();
  Future<LaundryScheduleData> getSchedule();
  Future<LaundryOrderSummary> getOrderSummary();
  Future<LaundryTrackingData> getTracking(String orderId);
}

abstract class CarRepository {
  Future<List<Vehicle>> getVehicles();
  Future<CarBookingData> getBookingDraft(String vehicleId);
}

abstract class TrackingRepository {
  Future<LiveTrackingData> getLiveTracking(String orderId);
}

abstract class CheckoutRepository {
  Future<CheckoutData> getCheckout(String orderId);
}

abstract class OrdersRepository {
  Future<List<OrderHistoryItem>> getOrders();
}

abstract class UserRepository {
  Future<UserProfile> getProfile();
}

abstract class HomeServicesRepository {
  Future<HomeServicesBundle> getBundle();
}

abstract class WalletRepository {
  Future<WalletData> getWallet();
}

abstract class NotificationsRepository {
  Future<List<AppNotification>> getNotifications();
}

abstract class ChatRepository {
  Future<ChatThread> getThread(String threadId);
}

abstract class SupportRepository {
  Future<({List<FaqItem> faqs, List<ContactOption> contacts})> getHelp();
}
