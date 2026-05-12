import 'package:equatable/equatable.dart';

// —— Hub ——
class HubSummary extends Equatable {
  const HubSummary({
    required this.locationLabel,
    required this.locationName,
    required this.promoTag,
    required this.promoTitle,
    required this.promoSubtitle,
    required this.promoCta,
    required this.services,
    required this.recentOrders,
  });

  final String locationLabel;
  final String locationName;
  final String promoTag;
  final String promoTitle;
  final String promoSubtitle;
  final String promoCta;
  final List<HubService> services;
  final List<HubRecentOrder> recentOrders;

  @override
  List<Object?> get props =>
      [locationLabel, locationName, promoTag, promoTitle, promoSubtitle, promoCta, services, recentOrders];
}

class HubService extends Equatable {
  const HubService({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconKey,
    required this.accentKey,
    required this.route,
  });

  final String id;
  final String title;
  final String subtitle;
  final String iconKey;
  final String accentKey;
  final String route;

  @override
  List<Object?> get props => [id, title, subtitle, iconKey, accentKey, route];
}

class HubRecentOrder extends Equatable {
  const HubRecentOrder({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.status,
    this.iconEmoji,
    this.iconKey,
  });

  final String id;
  final String type;
  final String title;
  final String subtitle;
  final String status;
  final String? iconEmoji;
  final String? iconKey;

  @override
  List<Object?> get props => [id, type, title, subtitle, status, iconEmoji, iconKey];
}

// —— Food ——
class FoodHomeData extends Equatable {
  const FoodHomeData({
    required this.locationShort,
    required this.cartCount,
    required this.categories,
    required this.dealTitle,
    required this.dealHeadline,
    required this.dealCta,
    required this.restaurants,
  });

  final String locationShort;
  final int cartCount;
  final List<FoodCategory> categories;
  final String dealTitle;
  final String dealHeadline;
  final String dealCta;
  final List<Restaurant> restaurants;

  @override
  List<Object?> get props =>
      [locationShort, cartCount, categories, dealTitle, dealHeadline, dealCta, restaurants];
}

class FoodCategory extends Equatable {
  const FoodCategory({required this.id, required this.label});
  final String id;
  final String label;

  @override
  List<Object?> get props => [id, label];
}

class Restaurant extends Equatable {
  const Restaurant({
    required this.id,
    required this.name,
    required this.minOrder,
    required this.rating,
    required this.eta,
    required this.delivery,
    required this.deliveryFree,
    required this.badge,
    required this.heroEmoji,
    required this.heroGradient,
  });

  final String id;
  final String name;
  final String minOrder;
  final double rating;
  final String eta;
  final String delivery;
  final bool deliveryFree;
  final String badge;
  final String heroEmoji;
  final List<String> heroGradient;

  @override
  List<Object?> get props =>
      [id, name, minOrder, rating, eta, delivery, deliveryFree, badge, heroEmoji, heroGradient];
}

// —— Laundry ——
class LaundryHomeData extends Equatable {
  const LaundryHomeData({
    required this.heroTag,
    required this.heroTitle,
    required this.heroSubtitle,
    required this.heroCta,
    required this.heroRating,
    required this.services,
    required this.coupons,
    required this.previousOrders,
  });

  final String heroTag;
  final String heroTitle;
  final String heroSubtitle;
  final String heroCta;
  final String heroRating;
  final List<LaundryServiceCard> services;
  final List<LaundryCoupon> coupons;
  final List<LaundryPrevOrder> previousOrders;

  @override
  List<Object?> get props =>
      [heroTag, heroTitle, heroSubtitle, heroCta, heroRating, services, coupons, previousOrders];
}

class LaundryServiceCard extends Equatable {
  const LaundryServiceCard({
    required this.id,
    required this.title,
    required this.priceFrom,
    required this.popular,
    required this.iconKey,
    this.accent,
  });

  final String id;
  final String title;
  final String priceFrom;
  final bool popular;
  final String iconKey;
  final String? accent;

  @override
  List<Object?> get props => [id, title, priceFrom, popular, iconKey, accent];
}

class LaundryCoupon extends Equatable {
  const LaundryCoupon({required this.code, required this.title, required this.subtitle, required this.gradient});
  final String code;
  final String title;
  final String subtitle;
  final List<String> gradient;

  @override
  List<Object?> get props => [code, title, subtitle, gradient];
}

class LaundryPrevOrder extends Equatable {
  const LaundryPrevOrder({
    required this.id,
    required this.type,
    required this.detail,
    required this.amount,
    required this.status,
  });

  final String id;
  final String type;
  final String detail;
  final String amount;
  final String status;

  @override
  List<Object?> get props => [id, type, detail, amount, status];
}

class LaundryScheduleData extends Equatable {
  const LaundryScheduleData({
    required this.addressTitle,
    required this.addressSubtitle,
    required this.dates,
    required this.timeSlots,
    required this.laundryTypes,
    required this.weightLabel,
    required this.weightHint,
    required this.weightUnits,
    required this.estimateLines,
    required this.totalEstimate,
  });

  final String addressTitle;
  final String addressSubtitle;
  final List<ScheduleDate> dates;
  final List<TimeSlot> timeSlots;
  final List<LaundryTypeChip> laundryTypes;
  final String weightLabel;
  final String weightHint;
  final int weightUnits;
  final List<EstimateLine> estimateLines;
  final String totalEstimate;

  @override
  List<Object?> get props => [
        addressTitle,
        addressSubtitle,
        dates,
        timeSlots,
        laundryTypes,
        weightLabel,
        weightHint,
        weightUnits,
        estimateLines,
        totalEstimate,
      ];
}

class ScheduleDate extends Equatable {
  const ScheduleDate({
    required this.weekday,
    required this.day,
    required this.month,
    required this.selected,
  });

  final String weekday;
  final int day;
  final String month;
  final bool selected;

  @override
  List<Object?> get props => [weekday, day, month, selected];
}

class TimeSlot extends Equatable {
  const TimeSlot({required this.id, required this.label, required this.icon, required this.selected});
  final String id;
  final String label;
  final String icon;
  final bool selected;

  @override
  List<Object?> get props => [id, label, icon, selected];
}

class LaundryTypeChip extends Equatable {
  const LaundryTypeChip({required this.id, required this.label, required this.selected});
  final String id;
  final String label;
  final bool selected;

  @override
  List<Object?> get props => [id, label, selected];
}

class EstimateLine extends Equatable {
  const EstimateLine({required this.label, required this.value, this.highlight});
  final String label;
  final String value;
  final String? highlight;

  @override
  List<Object?> get props => [label, value, highlight];
}

class LaundryOrderSummary extends Equatable {
  const LaundryOrderSummary({
    required this.orderId,
    required this.provider,
    required this.pickupDate,
    required this.pickupSlot,
    required this.deliveryDate,
    required this.deliverySlot,
    required this.items,
    required this.charges,
    required this.total,
    required this.paymentMethod,
  });

  final String orderId;
  final String provider;
  final String pickupDate;
  final String pickupSlot;
  final String deliveryDate;
  final String deliverySlot;
  final List<LaundryLineItem> items;
  final List<ChargeLine> charges;
  final String total;
  final String paymentMethod;

  @override
  List<Object?> get props =>
      [orderId, provider, pickupDate, pickupSlot, deliveryDate, deliverySlot, items, charges, total, paymentMethod];
}

class LaundryLineItem extends Equatable {
  const LaundryLineItem({required this.emoji, required this.title, required this.subtitle, required this.price});
  final String emoji;
  final String title;
  final String subtitle;
  final String price;

  @override
  List<Object?> get props => [emoji, title, subtitle, price];
}

class ChargeLine extends Equatable {
  const ChargeLine({required this.label, required this.value, this.highlight});
  final String label;
  final String value;
  final String? highlight;

  @override
  List<Object?> get props => [label, value, highlight];
}

class LaundryTrackingData extends Equatable {
  const LaundryTrackingData({
    required this.orderId,
    required this.status,
    required this.steps,
    required this.driverName,
    required this.driverPhone,
    required this.eta,
  });

  final String orderId;
  final String status;
  final List<TrackingStep> steps;
  final String driverName;
  final String driverPhone;
  final String eta;

  @override
  List<Object?> get props => [orderId, status, steps, driverName, driverPhone, eta];
}

class TrackingStep extends Equatable {
  const TrackingStep({required this.id, required this.title, required this.done, required this.time});
  final String id;
  final String title;
  final bool done;
  final String time;

  @override
  List<Object?> get props => [id, title, done, time];
}

// —— Car ——
class Vehicle extends Equatable {
  const Vehicle({
    required this.id,
    required this.name,
    required this.category,
    required this.pricePerDay,
    required this.pricePerHour,
    required this.rating,
    required this.trips,
    required this.features,
    required this.imageEmoji,
    required this.gradient,
  });

  final String id;
  final String name;
  final String category;
  final String pricePerDay;
  final String pricePerHour;
  final double rating;
  final int trips;
  final List<String> features;
  final String imageEmoji;
  final List<String> gradient;

  @override
  List<Object?> get props =>
      [id, name, category, pricePerDay, pricePerHour, rating, trips, features, imageEmoji, gradient];
}

class CarBookingData extends Equatable {
  const CarBookingData({
    required this.vehicleId,
    required this.vehicleName,
    required this.pickupLocation,
    required this.returnLocation,
    required this.startDate,
    required this.endDate,
    required this.addOns,
    required this.baseFare,
    required this.taxes,
    required this.total,
    required this.confirmationCode,
  });

  final String vehicleId;
  final String vehicleName;
  final String pickupLocation;
  final String returnLocation;
  final String startDate;
  final String endDate;
  final List<AddOn> addOns;
  final String baseFare;
  final String taxes;
  final String total;
  final String confirmationCode;

  @override
  List<Object?> get props => [
        vehicleId,
        vehicleName,
        pickupLocation,
        returnLocation,
        startDate,
        endDate,
        addOns,
        baseFare,
        taxes,
        total,
        confirmationCode,
      ];
}

class AddOn extends Equatable {
  const AddOn({required this.id, required this.label, required this.price});
  final String id;
  final String label;
  final String price;

  @override
  List<Object?> get props => [id, label, price];
}

// —— Tracking / Checkout ——
class TrackingLabelStep extends Equatable {
  const TrackingLabelStep({required this.label, required this.done});
  final String label;
  final bool done;

  @override
  List<Object?> get props => [label, done];
}

class LiveTrackingData extends Equatable {
  const LiveTrackingData({
    required this.orderType,
    required this.restaurant,
    required this.orderId,
    required this.status,
    required this.mapHint,
    required this.riderName,
    required this.riderRating,
    required this.eta,
    required this.steps,
  });

  final String orderType;
  final String restaurant;
  final String orderId;
  final String status;
  final String mapHint;
  final String riderName;
  final double riderRating;
  final String eta;
  final List<TrackingLabelStep> steps;

  @override
  List<Object?> get props =>
      [orderType, restaurant, orderId, status, mapHint, riderName, riderRating, eta, steps];
}

class CheckoutData extends Equatable {
  const CheckoutData({
    required this.restaurant,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.gst,
    required this.total,
    required this.paymentMethods,
  });

  final String restaurant;
  final List<CheckoutLine> items;
  final String subtotal;
  final String deliveryFee;
  final String gst;
  final String total;
  final List<PaymentMethodOption> paymentMethods;

  @override
  List<Object?> get props => [restaurant, items, subtotal, deliveryFee, gst, total, paymentMethods];
}

class CheckoutLine extends Equatable {
  const CheckoutLine({required this.name, required this.price});
  final String name;
  final String price;

  @override
  List<Object?> get props => [name, price];
}

class PaymentMethodOption extends Equatable {
  const PaymentMethodOption({required this.id, required this.label, required this.selected});
  final String id;
  final String label;
  final bool selected;

  @override
  List<Object?> get props => [id, label, selected];
}

// —— Orders ——
class OrderHistoryItem extends Equatable {
  const OrderHistoryItem({
    required this.id,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.status,
    this.emoji,
    this.iconKey,
    this.ratingNote,
  });

  final String id;
  final String category;
  final String title;
  final String subtitle;
  final String amount;
  final String status;
  final String? emoji;
  final String? iconKey;
  final String? ratingNote;

  @override
  List<Object?> get props => [id, category, title, subtitle, amount, status, emoji, iconKey, ratingNote];
}

// —— Profile ——
class UserProfile extends Equatable {
  const UserProfile({
    required this.name,
    required this.initials,
    required this.phone,
    required this.email,
    required this.ordersCount,
    required this.savedAmount,
    required this.rating,
    required this.voucherBadge,
  });

  final String name;
  final String initials;
  final String phone;
  final String email;
  final int ordersCount;
  final String savedAmount;
  final String rating;
  final int voucherBadge;

  @override
  List<Object?> get props =>
      [name, initials, phone, email, ordersCount, savedAmount, rating, voucherBadge];
}

// —— Home services ——
class HomeServiceCategory extends Equatable {
  const HomeServiceCategory({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.priceFrom,
    required this.icon,
    required this.rating,
  });

  final String id;
  final String title;
  final String subtitle;
  final String priceFrom;
  final String icon;
  final String rating;

  @override
  List<Object?> get props => [id, title, subtitle, priceFrom, icon, rating];
}

class HomeServicesBundle extends Equatable {
  const HomeServicesBundle({
    required this.services,
    required this.electricianDetailTitle,
    required this.electricianDetailBody,
    required this.electricianIncludes,
    required this.electricianHourly,
    required this.electricianVisit,
    required this.bookSlots,
    required this.providerName,
    required this.providerRole,
    required this.providerEta,
    required this.providerPhone,
    required this.completionTitle,
    required this.completionSubtitle,
    required this.completionAmount,
  });

  final List<HomeServiceCategory> services;
  final String electricianDetailTitle;
  final String electricianDetailBody;
  final List<String> electricianIncludes;
  final String electricianHourly;
  final String electricianVisit;
  final List<BookSlot> bookSlots;
  final String providerName;
  final String providerRole;
  final String providerEta;
  final String providerPhone;
  final String completionTitle;
  final String completionSubtitle;
  final String completionAmount;

  @override
  List<Object?> get props => [
        services,
        electricianDetailTitle,
        electricianDetailBody,
        electricianIncludes,
        electricianHourly,
        electricianVisit,
        bookSlots,
        providerName,
        providerRole,
        providerEta,
        providerPhone,
        completionTitle,
        completionSubtitle,
        completionAmount,
      ];
}

class BookSlot extends Equatable {
  const BookSlot({required this.id, required this.label, required this.available});
  final String id;
  final String label;
  final bool available;

  @override
  List<Object?> get props => [id, label, available];
}

// —— Wallet ——
class WalletData extends Equatable {
  const WalletData({
    required this.balance,
    required this.currency,
    required this.transactions,
    required this.quickAmounts,
  });

  final String balance;
  final String currency;
  final List<WalletTransaction> transactions;
  final List<int> quickAmounts;

  @override
  List<Object?> get props => [balance, currency, transactions, quickAmounts];
}

class WalletTransaction extends Equatable {
  const WalletTransaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
  });

  final String id;
  final String title;
  final String amount;
  final String date;
  final String type;

  @override
  List<Object?> get props => [id, title, amount, date, type];
}

// —— Notifications ——
class AppNotification extends Equatable {
  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.read,
    required this.icon,
  });

  final String id;
  final String title;
  final String body;
  final String time;
  final bool read;
  final String icon;

  @override
  List<Object?> get props => [id, title, body, time, read, icon];
}

// —— Chat ——
class ChatMessage extends Equatable {
  const ChatMessage({required this.id, required this.fromUser, required this.text, required this.time});
  final String id;
  final bool fromUser;
  final String text;
  final String time;

  @override
  List<Object?> get props => [id, fromUser, text, time];
}

class ChatThread extends Equatable {
  const ChatThread({
    required this.threadId,
    required this.providerName,
    required this.status,
    required this.messages,
  });

  final String threadId;
  final String providerName;
  final String status;
  final List<ChatMessage> messages;

  @override
  List<Object?> get props => [threadId, providerName, status, messages];
}

// —— Help ——
class FaqItem extends Equatable {
  const FaqItem({required this.id, required this.question, required this.answer});
  final String id;
  final String question;
  final String answer;

  @override
  List<Object?> get props => [id, question, answer];
}

class ContactOption extends Equatable {
  const ContactOption({required this.id, required this.label, required this.value});
  final String id;
  final String label;
  final String value;

  @override
  List<Object?> get props => [id, label, value];
}
