import '../../core/assets/app_assets.dart';
import '../../core/error/app_exception.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/app_repositories.dart';
import '../core/mock_asset_client.dart';

class HubRepositoryImpl implements HubRepository {
  HubRepositoryImpl(this._client);
  final MockAssetClient _client;

  @override
  Future<HubSummary> getHub() async {
    final j = await _client.getJson(AppAssets.hubJson);
    return HubSummary(
      locationLabel: j['locationLabel'] as String,
      locationName: j['locationName'] as String,
      promoTag: j['promoTag'] as String,
      promoTitle: j['promoTitle'] as String,
      promoSubtitle: j['promoSubtitle'] as String,
      promoCta: j['promoCta'] as String,
      services: (j['services'] as List<dynamic>)
          .map((e) => HubService(
                id: e['id'] as String,
                title: e['title'] as String,
                subtitle: e['subtitle'] as String,
                iconKey: e['iconKey'] as String,
                accentKey: e['accentColor'] as String,
                route: e['route'] as String,
              ))
          .toList(),
      recentOrders: (j['recentOrders'] as List<dynamic>)
          .map((e) => HubRecentOrder(
                id: e['id'] as String,
                type: e['type'] as String,
                title: e['title'] as String,
                subtitle: e['subtitle'] as String,
                status: e['status'] as String,
                iconEmoji: e['iconEmoji'] as String?,
                iconKey: e['iconKey'] as String?,
              ))
          .toList(),
    );
  }
}

class FoodRepositoryImpl implements FoodRepository {
  FoodRepositoryImpl(this._client);
  final MockAssetClient _client;

  @override
  Future<FoodHomeData> getFoodHome() async {
    final j = await _client.getJson(AppAssets.foodRestaurantsJson);
    return FoodHomeData(
      locationShort: j['locationShort'] as String,
      cartCount: j['cartCount'] as int,
      categories: (j['categories'] as List<dynamic>)
          .map((e) => FoodCategory(id: e['id'] as String, label: e['label'] as String))
          .toList(),
      dealTitle: j['dealTitle'] as String,
      dealHeadline: j['dealHeadline'] as String,
      dealCta: j['dealCta'] as String,
      restaurants: (j['restaurants'] as List<dynamic>).map((e) {
        return Restaurant(
          id: e['id'] as String,
          name: e['name'] as String,
          minOrder: e['minOrder'] as String,
          rating: (e['rating'] as num).toDouble(),
          eta: e['eta'] as String,
          delivery: e['delivery'] as String,
          deliveryFree: e['deliveryFree'] as bool,
          badge: e['badge'] as String,
          heroEmoji: e['heroEmoji'] as String,
          heroGradient: (e['heroGradient'] as List<dynamic>).map((x) => x as String).toList(),
        );
      }).toList(),
    );
  }
}

class LaundryRepositoryImpl implements LaundryRepository {
  LaundryRepositoryImpl(this._client);
  final MockAssetClient _client;

  @override
  Future<LaundryHomeData> getLaundryHome() async {
    final j = await _client.getJson(AppAssets.laundryHomeJson);
    return LaundryHomeData(
      heroTag: j['heroTag'] as String,
      heroTitle: j['heroTitle'] as String,
      heroSubtitle: j['heroSubtitle'] as String,
      heroCta: j['heroCta'] as String,
      heroRating: j['heroRating'] as String,
      services: (j['services'] as List<dynamic>)
          .map((e) => LaundryServiceCard(
                id: e['id'] as String,
                title: e['title'] as String,
                priceFrom: e['priceFrom'] as String,
                popular: e['popular'] as bool,
                iconKey: e['iconKey'] as String,
                accent: e['accent'] as String?,
              ))
          .toList(),
      coupons: (j['coupons'] as List<dynamic>)
          .map((e) => LaundryCoupon(
                code: e['code'] as String,
                title: e['title'] as String,
                subtitle: e['subtitle'] as String,
                gradient: (e['gradient'] as List<dynamic>).map((x) => x as String).toList(),
              ))
          .toList(),
      previousOrders: (j['previousOrders'] as List<dynamic>)
          .map((e) => LaundryPrevOrder(
                id: e['id'] as String,
                type: e['type'] as String,
                detail: e['detail'] as String,
                amount: e['amount'] as String,
                status: e['status'] as String,
              ))
          .toList(),
    );
  }

  @override
  Future<LaundryScheduleData> getSchedule() async {
    final j = await _client.getJson(AppAssets.laundryScheduleJson);
    return LaundryScheduleData(
      addressTitle: j['addressTitle'] as String,
      addressSubtitle: j['addressSubtitle'] as String,
      dates: (j['dates'] as List<dynamic>)
          .map((e) => ScheduleDate(
                weekday: e['weekday'] as String,
                day: (e['day'] as num).toInt(),
                month: e['month'] as String,
                selected: e['selected'] as bool,
              ))
          .toList(),
      timeSlots: (j['timeSlots'] as List<dynamic>)
          .map((e) => TimeSlot(
                id: e['id'] as String,
                label: e['label'] as String,
                icon: e['icon'] as String,
                selected: e['selected'] as bool,
              ))
          .toList(),
      laundryTypes: (j['laundryTypes'] as List<dynamic>)
          .map((e) => LaundryTypeChip(
                id: e['id'] as String,
                label: e['label'] as String,
                selected: e['selected'] as bool,
              ))
          .toList(),
      weightLabel: j['weightLabel'] as String,
      weightHint: j['weightHint'] as String,
      weightUnits: (j['weightUnits'] as num).toInt(),
      estimateLines: (j['estimateLines'] as List<dynamic>)
          .map((e) => EstimateLine(
                label: e['label'] as String,
                value: e['value'] as String,
                highlight: e['highlight'] as String?,
              ))
          .toList(),
      totalEstimate: j['totalEstimate'] as String,
    );
  }

  @override
  Future<LaundryOrderSummary> getOrderSummary() async {
    final j = await _client.getJson(AppAssets.laundryOrderSummaryJson);
    return LaundryOrderSummary(
      orderId: j['orderId'] as String,
      provider: j['provider'] as String,
      pickupDate: j['pickupDate'] as String,
      pickupSlot: j['pickupSlot'] as String,
      deliveryDate: j['deliveryDate'] as String,
      deliverySlot: j['deliverySlot'] as String,
      items: (j['items'] as List<dynamic>)
          .map((e) => LaundryLineItem(
                emoji: e['emoji'] as String,
                title: e['title'] as String,
                subtitle: e['subtitle'] as String,
                price: e['price'] as String,
              ))
          .toList(),
      charges: (j['charges'] as List<dynamic>)
          .map((e) => ChargeLine(
                label: e['label'] as String,
                value: e['value'] as String,
                highlight: e['highlight'] as String?,
              ))
          .toList(),
      total: j['total'] as String,
      paymentMethod: j['paymentMethod'] as String,
    );
  }

  @override
  Future<LaundryTrackingData> getTracking(String orderId) async {
    final j = await _client.getJson(AppAssets.laundryTrackingJson);
    return LaundryTrackingData(
      orderId: j['orderId'] as String,
      status: j['status'] as String,
      steps: (j['steps'] as List<dynamic>)
          .map((e) => TrackingStep(
                id: e['id'] as String,
                title: e['title'] as String,
                done: e['done'] as bool,
                time: e['time'] as String,
              ))
          .toList(),
      driverName: j['driverName'] as String,
      driverPhone: j['driverPhone'] as String,
      eta: j['eta'] as String,
    );
  }
}

class CarRepositoryImpl implements CarRepository {
  CarRepositoryImpl(this._client);
  final MockAssetClient _client;

  @override
  Future<List<Vehicle>> getVehicles() async {
    final j = await _client.getJson(AppAssets.carListingsJson);
    return (j['vehicles'] as List<dynamic>).map((e) {
      return Vehicle(
        id: e['id'] as String,
        name: e['name'] as String,
        category: e['category'] as String,
        pricePerDay: e['pricePerDay'] as String,
        pricePerHour: e['pricePerHour'] as String,
        rating: (e['rating'] as num).toDouble(),
        trips: (e['trips'] as num).toInt(),
        features: (e['features'] as List<dynamic>).map((x) => x as String).toList(),
        imageEmoji: e['imageEmoji'] as String,
        gradient: (e['gradient'] as List<dynamic>).map((x) => x as String).toList(),
      );
    }).toList();
  }

  @override
  Future<CarBookingData> getBookingDraft(String vehicleId) async {
    final j = await _client.getJson(AppAssets.carBookingJson);
    return CarBookingData(
      vehicleId: j['vehicleId'] as String,
      vehicleName: j['vehicleName'] as String,
      pickupLocation: j['pickupLocation'] as String,
      returnLocation: j['returnLocation'] as String,
      startDate: j['startDate'] as String,
      endDate: j['endDate'] as String,
      addOns: (j['addOns'] as List<dynamic>)
          .map((e) => AddOn(id: e['id'] as String, label: e['label'] as String, price: e['price'] as String))
          .toList(),
      baseFare: j['baseFare'] as String,
      taxes: j['taxes'] as String,
      total: j['total'] as String,
      confirmationCode: j['confirmationCode'] as String,
    );
  }
}

class TrackingRepositoryImpl implements TrackingRepository {
  TrackingRepositoryImpl(this._client);
  final MockAssetClient _client;

  @override
  Future<LiveTrackingData> getLiveTracking(String orderId) async {
    final j = await _client.getJson(AppAssets.trackingJson);
    final stepsRaw = j['steps'] as List<dynamic>? ?? [];
    final steps = stepsRaw.map((e) {
      if (e is Map<String, dynamic>) {
        return TrackingLabelStep(label: e['label'] as String? ?? '', done: e['done'] as bool? ?? false);
      }
      return const TrackingLabelStep(label: '', done: false);
    }).toList();
    return LiveTrackingData(
      orderType: j['orderType'] as String,
      restaurant: j['restaurant'] as String,
      orderId: j['orderId'] as String,
      status: j['status'] as String,
      mapHint: j['mapHint'] as String,
      riderName: j['riderName'] as String,
      riderRating: (j['riderRating'] as num).toDouble(),
      eta: j['eta'] as String,
      steps: steps,
    );
  }
}

class CheckoutRepositoryImpl implements CheckoutRepository {
  CheckoutRepositoryImpl(this._client);
  final MockAssetClient _client;

  @override
  Future<CheckoutData> getCheckout(String orderId) async {
    final j = await _client.getJson(AppAssets.checkoutJson);
    return CheckoutData(
      restaurant: j['restaurant'] as String,
      items: (j['items'] as List<dynamic>)
          .map((e) => CheckoutLine(name: e['name'] as String, price: e['price'] as String))
          .toList(),
      subtotal: j['subtotal'] as String,
      deliveryFee: j['deliveryFee'] as String,
      gst: j['gst'] as String,
      total: j['total'] as String,
      paymentMethods: (j['paymentMethods'] as List<dynamic>)
          .map((e) => PaymentMethodOption(
                id: e['id'] as String,
                label: e['label'] as String,
                selected: e['selected'] as bool,
              ))
          .toList(),
    );
  }
}

class OrdersRepositoryImpl implements OrdersRepository {
  OrdersRepositoryImpl(this._client);
  final MockAssetClient _client;

  @override
  Future<List<OrderHistoryItem>> getOrders() async {
    final j = await _client.getJson(AppAssets.orderHistoryJson);
    return (j['orders'] as List<dynamic>).map((e) {
      return OrderHistoryItem(
        id: e['id'] as String,
        category: e['category'] as String,
        title: e['title'] as String,
        subtitle: e['subtitle'] as String,
        amount: e['amount'] as String,
        status: e['status'] as String,
        emoji: e['emoji'] as String?,
        iconKey: e['iconKey'] as String?,
        ratingNote: e['ratingNote'] as String?,
      );
    }).toList();
  }
}

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._client);
  final MockAssetClient _client;

  @override
  Future<UserProfile> getProfile() async {
    final j = await _client.getJson(AppAssets.userProfileJson);
    return UserProfile(
      name: j['name'] as String,
      initials: j['initials'] as String,
      phone: j['phone'] as String,
      email: j['email'] as String,
      ordersCount: (j['ordersCount'] as num).toInt(),
      savedAmount: j['savedAmount'] as String,
      rating: j['rating'] as String,
      voucherBadge: (j['voucherBadge'] as num).toInt(),
    );
  }
}

class HomeServicesRepositoryImpl implements HomeServicesRepository {
  HomeServicesRepositoryImpl(this._client);
  final MockAssetClient _client;

  @override
  Future<HomeServicesBundle> getBundle() async {
    final j = await _client.getJson(AppAssets.homeServicesJson);
    final ed = j['electricianDetail'] as Map<String, dynamic>;
    final pt = j['providerTracking'] as Map<String, dynamic>;
    final cp = j['completion'] as Map<String, dynamic>;
    return HomeServicesBundle(
      services: (j['services'] as List<dynamic>)
          .map((e) => HomeServiceCategory(
                id: e['id'] as String,
                title: e['title'] as String,
                subtitle: e['subtitle'] as String,
                priceFrom: e['priceFrom'] as String,
                icon: e['icon'] as String,
                rating: e['rating'] as String,
              ))
          .toList(),
      electricianDetailTitle: ed['title'] as String,
      electricianDetailBody: ed['description'] as String,
      electricianIncludes: (ed['includes'] as List<dynamic>).map((x) => x as String).toList(),
      electricianHourly: ed['hourly'] as String,
      electricianVisit: ed['visitFee'] as String,
      bookSlots: (j['bookSlots'] as List<dynamic>)
          .map((e) => BookSlot(
                id: e['id'] as String,
                label: e['label'] as String,
                available: e['available'] as bool,
              ))
          .toList(),
      providerName: pt['name'] as String,
      providerRole: pt['role'] as String,
      providerEta: pt['eta'] as String,
      providerPhone: pt['phone'] as String,
      completionTitle: cp['title'] as String,
      completionSubtitle: cp['subtitle'] as String,
      completionAmount: cp['amount'] as String,
    );
  }
}

class WalletRepositoryImpl implements WalletRepository {
  WalletRepositoryImpl(this._client);
  final MockAssetClient _client;

  @override
  Future<WalletData> getWallet() async {
    final j = await _client.getJson(AppAssets.walletJson);
    return WalletData(
      balance: j['balance'] as String,
      currency: j['currency'] as String,
      transactions: (j['transactions'] as List<dynamic>)
          .map((e) => WalletTransaction(
                id: e['id'] as String,
                title: e['title'] as String,
                amount: e['amount'] as String,
                date: e['date'] as String,
                type: e['type'] as String,
              ))
          .toList(),
      quickAmounts: (j['quickAmounts'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
    );
  }
}

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._client);
  final MockAssetClient _client;

  @override
  Future<List<AppNotification>> getNotifications() async {
    final j = await _client.getJson(AppAssets.notificationsJson);
    return (j['items'] as List<dynamic>)
        .map((e) => AppNotification(
              id: e['id'] as String,
              title: e['title'] as String,
              body: e['body'] as String,
              time: e['time'] as String,
              read: e['read'] as bool,
              icon: e['icon'] as String,
            ))
        .toList();
  }
}

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._client);
  final MockAssetClient _client;

  @override
  Future<ChatThread> getThread(String threadId) async {
    final j = await _client.getJson(AppAssets.chatJson);
    return ChatThread(
      threadId: j['threadId'] as String,
      providerName: j['providerName'] as String,
      status: j['status'] as String,
      messages: (j['messages'] as List<dynamic>)
          .map((e) => ChatMessage(
                id: e['id'] as String,
                fromUser: (e['from'] as String) == 'user',
                text: e['text'] as String,
                time: e['time'] as String,
              ))
          .toList(),
    );
  }
}

class SupportRepositoryImpl implements SupportRepository {
  SupportRepositoryImpl(this._client);
  final MockAssetClient _client;

  @override
  Future<({List<FaqItem> faqs, List<ContactOption> contacts})> getHelp() async {
    final j = await _client.getJson(AppAssets.helpSupportJson);
    final faqs = (j['faqs'] as List<dynamic>)
        .map((e) => FaqItem(
              id: e['id'] as String,
              question: e['q'] as String,
              answer: e['a'] as String,
            ))
        .toList();
    final contacts = (j['contactOptions'] as List<dynamic>)
        .map((e) => ContactOption(
              id: e['id'] as String,
              label: e['label'] as String,
              value: e['value'] as String,
            ))
        .toList();
    return (faqs: faqs, contacts: contacts);
  }
}
