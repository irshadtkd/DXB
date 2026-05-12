/// All user-visible copy. Do not inline strings in widgets.
abstract final class AppStrings {
  static const String appName = 'MultiServe';
  static const String designCredit =
      'MultiServe · User App — Complete flows · Deep Indigo + Amber + Sage';

  // Splash
  static const String splashTagline = 'Your city, at your service';
  static const String splashLoading = 'Loading';
  static const String splashFood = 'Food';
  static const String splashLaundry = 'Laundry';
  static const String splashRental = 'Rental';
  static const String splashHome = 'Home';

  // Onboarding
  static const String ob1Title = 'Food from your\nfavourite spots';
  static const String ob1Body =
      'Order from 500+ restaurants nearby with lightning-fast delivery to your door.';
  static const String ob1Bubble1 = '30 min avg';
  static const String ob1Bubble2 = '500+ Restaurants';
  static const String obGetStarted = 'Get Started';
  static const String obAlreadyAccount = 'Already have an account? ';
  static const String obSignIn = 'Sign in';

  static const String ob2Title = 'All your services,\none app';
  static const String ob2Body =
      'From laundry to car rentals and home repairs — everything you need, just a tap away.';
  static const String obContinue = 'Continue';
  static const String obSkip = 'Skip for now';

  // Auth
  static const String authWelcome = 'Welcome back!';
  static const String authPhoneHint =
      'Enter your phone number to get\na verification code.';
  static const String authPhoneLabel = 'Phone Number';
  static const String authOtpLabel = 'Verification Code';
  static const String authResend = 'Resend code in ';
  static const String authVerify = 'Verify & Continue';
  static const String authOrContinue = 'or continue with';
  static const String authGoogle = 'Google';
  static const String authApple = 'Apple';

  // Hub
  static const String hubDeliveringTo = 'Delivering to';
  static const String hubSearchHint = 'Search services, restaurants...';
  static const String hubOurServices = 'Our Services';
  static const String hubViewAll = 'View all';
  static const String hubRecentOrders = 'Recent Orders';
  static const String hubHistory = 'History';
  static const String hubLimitedOffer = 'Limited Offer';

  // Bottom nav
  static const String navHome = 'Home';
  static const String navOrders = 'Orders';
  static const String navExplore = 'Explore';
  static const String navProfile = 'Profile';
  static const String navSaved = 'Saved';

  // Food
  static const String foodTitle = '🍽 Food';
  static const String foodSearchHint = 'Search dishes, restaurants...';
  static const String foodPopularNearby = 'Popular Nearby';
  static const String foodMin = 'min';

  // Laundry
  static const String laundryTitle = '🧺 Laundry';
  static const String laundryServices = 'Services';
  static const String laundryPriceList = 'Price list';
  static const String laundryOffers = 'Offers & Coupons';
  static const String laundryPrevious = 'Previous Orders';
  static const String laundryReorder = 'Reorder';
  static const String laundrySchedulePickup = 'Schedule Pickup';
  static const String laundryScheduleTitle = 'Schedule Pickup';
  static const String laundryPickupAddress = 'Pickup Address';
  static const String laundryAddAddress = 'Add new address';
  static const String laundryPickupDate = 'Pickup Date';
  static const String laundryTimeSlot = 'Pickup Time Slot';
  static const String laundryType = 'Laundry Type';
  static const String laundryQuantity = 'Est. Quantity / Weight';
  static const String laundryInstructions = 'Special Instructions';
  static const String laundryInstructionsHint =
      'e.g. Handle silk gently, separate whites...';
  static const String laundryAddCoupon = 'Add Coupon / Promo Code';
  static const String laundryEstimated = 'Estimated Price';
  static const String laundryCancel = 'Cancel';
  static const String laundryEstDisclaimer =
      '* Final price may vary by actual weight';
  static const String laundryOrderSummary = 'Order Summary';
  static const String laundryOrderConfirmed = 'Order Confirmed!';
  static const String laundryItems = 'Laundry Items';
  static const String laundryCharges = 'Charges';
  static const String laundryPay = 'Pay';
  static const String laundryPayWithPrefix = 'Pay with';
  static const String laundryPickupColumn = 'Pickup';
  static const String laundryDeliveryColumn = 'Delivery';
  static const String laundryTracking = 'Track Order';
  static const String laundryOutForDelivery = 'Out for delivery';

  // Car rental
  static const String carTitle = '🚗 Car Rental';
  static const String carPopular = 'Popular near you';
  static const String carPerDay = '/day';
  static const String carPerHour = '/hr';
  static const String carBookNow = 'Book Now';
  static const String carDetails = 'Vehicle details';
  static const String carBookingTitle = 'Booking';
  static const String carConfirmation = 'Booking confirmed';
  static const String carPickup = 'Pickup';
  static const String carReturn = 'Return';

  // Tracking
  static const String trackingTitle = 'Live tracking';
  static const String trackingMapHint = 'Map preview · Connect API for live map';

  // Checkout
  static const String checkoutTitle = 'Checkout';
  static const String checkoutPromoHint = 'Enter promo code';
  static const String checkoutApply = 'Apply';
  static const String checkoutPaymentMethod = 'Payment Method';
  static const String checkoutPlaceOrder = 'Place Order';
  static const String checkoutSecure = 'Secured by SSL encryption';

  // Orders
  static const String ordersTitle = 'Order History';
  static const String ordersAll = 'All Orders';
  static const String ordersFilterFood = '🍽 Food';
  static const String ordersFilterLaundry = '🧺 Laundry';
  static const String ordersFilterCar = '🚗 Car';
  static const String ordersReorder = 'Reorder';
  static const String ordersTrack = 'Track';

  // Profile
  static const String profileTitle = 'My Profile';
  static const String profileEdit = 'Edit';
  static const String profileOrders = 'Orders';
  static const String profileSaved = 'Saved';
  static const String profileRating = 'Rating';
  static const String profileAddresses = 'Saved Addresses';
  static const String profilePayments = 'Payment Methods';
  static const String profileVouchers = 'Vouchers & Offers';
  static const String profileNotifications = 'Notifications';
  static const String profilePrivacy = 'Privacy & Security';
  static const String profileHelp = 'Help & Support';
  static const String profileReferTitle = 'Refer & Earn';
  static const String profileReferBody =
      'Get ₹100 for every friend you invite';
  static const String profileInvite = 'Invite';
  static const String profileSignOut = 'Sign Out';

  // Home services
  static const String hsTitle = '🏠 Home Services';
  static const String hsSameDay = 'Same-Day Available';
  static const String hsHeroTitle = 'Expert pros at\nyour doorstep';
  static const String hsHeroSub = 'Verified · Insured · Background checked';
  static const String hsBookService = 'Book service';
  static const String hsPickSlot = 'Choose a time slot';
  static const String hsServiceDetails = 'Service details';
  static const String hsProviderTracking = 'Provider on the way';
  static const String hsCompletion = 'Completion';

  // Wallet
  static const String walletTitle = 'Wallet';
  static const String walletBalance = 'Available balance';
  static const String walletAddMoney = 'Add Money';
  static const String walletRecent = 'Recent activity';
  static const String walletQuickAdd = 'Quick add';

  // Notifications
  static const String notificationsTitle = 'Notifications';
  static const String notificationsEmpty = 'You are all caught up';

  // Chat
  static const String chatTitle = 'Chat';
  static const String chatInbox = 'Messages';
  static const String chatHint = 'Type a message...';
  static const String chatSend = 'Send';

  // Review
  static const String reviewTitle = 'Rate your experience';
  static const String reviewSubmit = 'Submit review';
  static const String reviewSkip = 'Skip';

  static String reviewOrderLabel(String orderId) => 'Order $orderId';

  // Help
  static const String helpTitle = 'Help & Support';
  static const String helpFaq = 'FAQs';
  static const String helpContact = 'Contact us';

  // Explore
  static const String exploreTitle = 'Explore';
  static const String exploreSubtitle = 'Discover services and offers near you';

  // Common
  static const String commonRetry = 'Retry';
  static const String commonErrorTitle = 'Something went wrong';
  static const String commonEmptyTitle = 'Nothing here yet';
  static const String commonEmptySubtitle = 'Pull to refresh or try again later';
  static const String commonOk = 'OK';
  static const String commonCancel = 'Cancel';
  static const String commonClose = 'Close';
  static const String commonLoading = 'Loading...';
  static const String commonUnavailable = 'Unavailable';
  static const String commonDelivered = 'Delivered';
  static const String commonInProgress = 'In Progress';
  static const String commonTotal = 'Total';
  static const String commonSubtotal = 'Subtotal';
  static const String commonDeliveryFee = 'Delivery fee';
  static const String commonGst = 'GST & charges';
  static const String commonTaxes = 'Taxes';
  static const String commonFree = 'FREE';
  static const String carStart = 'Start';
  static const String carEnd = 'End';
  static const String networkError =
      'Please check your connection and try again.';
}
