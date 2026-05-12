/// Central route path constants for [GoRouter].
abstract final class RoutePaths {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';

  static const String hub = '/hub';
  static const String ordersTab = '/orders';
  static const String explore = '/explore';
  static const String profileTab = '/profile';

  static const String food = '/food';
  static const String laundry = '/laundry';
  static const String laundrySchedule = '/laundry/schedule';
  static const String laundrySummary = '/laundry/summary';
  static const String laundryTracking = '/laundry/tracking';

  static const String car = '/car';
  static String carDetail(String id) => '/car/$id';
  static String carBook(String id) => '/car/$id/book';
  static String carConfirm(String id) => '/car/$id/confirm';

  static String tracking(String orderId) => '/tracking/$orderId';
  static String checkout(String orderId) => '/checkout/$orderId';

  static const String homeServices = '/home-services';
  static String homeServiceDetail(String id) => '/home-services/$id';
  static const String homeServiceBook = '/home-services/book';
  static String homeServiceTrack(String id) => '/home-services/track/$id';
  static String homeServiceComplete(String id) => '/home-services/complete/$id';

  static const String wallet = '/wallet';
  static const String walletAdd = '/wallet/add';

  static const String notifications = '/notifications';
  static String chat(String threadId) => '/chat/$threadId';
  static String review(String orderId) => '/review/$orderId';
  static const String help = '/help';
}
