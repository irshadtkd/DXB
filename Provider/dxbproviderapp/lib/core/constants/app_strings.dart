/// All user-visible strings (no inline literals in UI).
abstract final class AppStrings {
  static const String appName = 'Provify Provider';

  // Common
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String submit = 'Submit';
  static const String next = 'Next';
  static const String back = 'Back';
  static const String done = 'Done';
  static const String search = 'Search';
  static const String seeAll = 'See all';
  static const String loading = 'Loading…';
  static const String emptyTitle = 'Nothing here yet';
  static const String emptySubtitle = 'Pull to refresh or try again later.';
  static const String errorTitle = 'Something went wrong';
  static const String dismiss = 'Dismiss';

  // Nav
  static const String navHome = 'Home';
  static const String navOrders = 'Orders';
  static const String navCatalog = 'Catalog';
  static const String navInbox = 'Inbox';
  static const String navAccount = 'Account';

  // Splash
  static const String splashTagline = 'Grow your business with Provify';
  static const String splashLoading = 'Preparing your workspace…';

  // Tutorial (first-launch setup)
  static const String tutorialSkip = 'Skip';
  static const String tutorialNext = 'Next';
  static const String tutorialGetStarted = 'Get started';
  static const String tutorialSlide1Title = 'Orders in one place';
  static const String tutorialSlide1Body = 'Accept, prepare, and track every order with clear status updates.';
  static const String tutorialSlide2Title = 'Catalog & availability';
  static const String tutorialSlide2Body = 'Manage menus, services, and time windows across all your verticals.';
  static const String tutorialSlide3Title = 'Earnings & payouts';
  static const String tutorialSlide3Body = 'See revenue at a glance and get paid on schedule with bank or UPI.';
  static const String tutorialSlide4Title = 'Stay in touch';
  static const String tutorialSlide4Body = 'Chat with customers and support without leaving the app.';

  // Welcome (optional; main cold start goes Splash → Tutorial → Login)
  static const String welcomeTitle = 'Welcome to Provify';
  static const String welcomeSubtitle = 'Sign in to manage orders and services, or create a new provider account.';
  static const String welcomeSignIn = 'Sign in';
  static const String welcomeCreateAccount = 'Create provider account';

  // Login
  static const String loginTitle = 'Sign in';
  static const String loginSubtitle = 'Use email or phone to receive a one-time code.';
  static const String loginEmailTab = 'Email';
  static const String loginPhoneTab = 'Phone';
  static const String loginEmailHint = 'Email address';
  static const String loginPhoneHint = 'Phone number';
  static const String loginSendOtp = 'Send OTP';
  static const String loginVerifyOtp = 'Verify & continue';
  static const String loginOtpHint = 'Enter 6-digit code';
  static const String loginNoAccount = 'New provider? ';
  static const String loginRegister = 'Register';
  static const String loginPhoneCountryHint = 'Use your registered mobile (e.g. +971 5X XXX XXXX)';
  static const String loginResendOtp = 'Resend code';
  static const String loginInvalidEmail = 'Enter a valid email';
  static const String loginInvalidPhone = 'Enter a valid mobile number';
  static const String registerBusinessTitle = 'Business details';
  static const String registerBusinessSubtitle = 'Tell us about your business and which services you offer.';
  static const String registerSelectServicesTitle = 'Services you offer';
  static const String registerSelectServicesSubtitle = 'Select all that apply. One mobile number or email can cover multiple services.';
  static const String registerCategoryFood = 'Food';
  static const String registerCategoryLaundry = 'Laundry';
  static const String registerCategoryRental = 'Rental';
  static const String registerCategoryHomeServices = 'Home services';
  static const String registerCategoriesRequired = 'Select at least one category';
  static const String fieldBusinessName = 'Business name';
  static const String fieldTradeLicense = 'Trade license number';
  static const String fieldAddress = 'Address';
  static const String fieldCity = 'City';
  static const String registerDocsTitle = 'Documents';
  static const String registerDocsSubtitle = 'Upload license and ID for verification.';
  static const String uploadLicense = 'Trade license (PDF / image)';
  static const String uploadId = 'Owner ID (image)';
  static const String uploadTap = 'Tap to upload';
  static const String registerSubmit = 'Submit for review';

  // Account status
  static const String statusPendingTitle = 'Pending approval';
  static const String statusPendingBody =
      'We are reviewing your documents. You will be notified once verified.';
  static const String statusRejectedTitle = 'Application rejected';
  static const String statusRejectedBody =
      'Please update your documents and resubmit. Contact support if you need help.';
  static const String statusSuspendedTitle = 'Account suspended';
  static const String statusSuspendedBody =
      'Your account is read-only. You cannot accept new orders until the review completes.';
  static const String contactSupport = 'Contact support';
  static const String resubmit = 'Resubmit documents';
  static const String goHome = 'Go to home';

  // Dashboard
  static const String dashGoodMorning = 'Good morning';
  static const String dashGoodAfternoon = 'Good afternoon';
  static const String dashGoodEvening = 'Good evening';
  static const String dashTodayRevenue = "Today's revenue";
  static const String dashVsYesterday = 'vs yesterday';
  static const String dashKpiOrders = "Today's orders";
  static const String dashKpiCompletion = 'Completion';
  static const String dashKpiRating = 'Rating';
  static const String dashSlaRisk = 'SLA risk';
  static const String dashAlertsTasks = 'Alerts & tasks';
  static const String dashPendingCount = 'pending';
  static const String dashQuickActions = 'Quick actions';
  static const String qaAddItem = 'Add item';
  static const String qaViewOrders = 'View orders';
  static const String qaEarnings = 'Earnings';
  static const String qaReports = 'Reports';
  static const String dashRecentOrders = 'Recent orders';
  static const String dashWeeklyEarnings = 'Weekly earnings';
  static const String dashThisWeek = 'This week';
  static const String notifications = 'Notifications';

  // Orders
  static const String ordersTitle = 'Orders';
  static const String ordersTodayBadge = 'Today';
  static const String orderDetailTitle = 'Order detail';
  static const String orderStatusUpdate = 'Update status';
  static const String orderAssignRider = 'Assign rider';
  static const String orderProofUpload = 'Completion proof';
  static const String orderProofSubtitle = 'Upload photo or document to confirm completion.';
  static const String orderSelectStatus = 'Select new status';
  static const String orderConfirmStatus = 'Update';
  static const String orderRiderTitle = 'Assign delivery partner';
  static const String orderRiderSubtitle = 'Pick an available rider.';
  static const String orderAssign = 'Assign';
  static const String orderCustomer = 'Customer';
  static const String orderItems = 'Items';
  static const String orderTimeline = 'Timeline';
  static const String orderTotal = 'Total';

  // Catalog
  static const String catalogHubTitle = 'Catalog hub';
  static const String catalogNoSelectedServicesTitle = 'No catalog sections yet';
  static const String catalogNoSelectedServicesBody =
      'Register and choose your service categories, or sign in after your account is approved, to see menus and listings here.';
  static const String catalogFoodTitle = 'Food menu';
  static const String catalogAvailabilityTitle = 'Availability windows';
  static const String catalogLaundryTitle = 'Laundry services';
  static const String catalogCarsTitle = 'Car rental fleet';
  static const String catalogHotelsTitle = 'Hotel rooms';
  static const String catalogMarketTitle = 'Marketplace / SKU';
  static const String catalogHomeSvcTitle = 'Home services';
  static const String catalogAdd = 'Add';
  static const String catalogEdit = 'Edit';

  // Customers
  static const String customersTitle = 'Customers';
  static const String customerDetailTitle = 'Customer';
  static const String customerOrders = 'Orders';
  static const String customerSpend = 'Lifetime spend';

  // Inbox
  static const String inboxTitle = 'Messages';
  static const String chatTitle = 'Chat';
  static const String attachmentsTitle = 'Attachments';
  static const String typeMessage = 'Type a message…';
  static const String send = 'Send';

  // Account hub
  static const String accountTitle = 'Account';
  static const String accountProfile = 'Profile';
  static const String accountEarnings = 'Earnings overview';
  static const String accountPayouts = 'Payout history';
  static const String accountBank = 'Bank & UPI';
  static const String accountAnalytics = 'Analytics';
  static const String accountReviews = 'Reviews';
  static const String accountSettings = 'Business settings';
  static const String accountHelp = 'Help center';
  static const String accountWebTools = 'Business tools';
  static const String signOut = 'Sign out';

  // Earnings
  static const String earningsTitle = 'Earnings';
  static const String payoutsTitle = 'Payouts';
  static const String bankTitle = 'Bank & UPI';
  static const String bankSubtitle = 'Manage how you receive payouts.';
  static const String bankFieldBank = 'Bank name';
  static const String bankFieldHolder = 'Account holder';
  static const String bankFieldIban = 'IBAN';
  static const String bankFieldUpi = 'UPI ID';

  // Analytics
  static const String analyticsOverviewTitle = 'Overview';
  static const String analyticsVerticalTitle = 'Vertical performance';
  static const String analyticsOpsTitle = 'Operational metrics';
  static const String percentShare = '% share';

  // Reviews
  static const String reviewsTitle = 'Reviews';
  static const String reviewDetailTitle = 'Review';
  static const String reviewReply = 'Your response';
  static const String reviewPostReply = 'Post response';

  // Settings
  static const String businessProfileTitle = 'Business profile';
  static const String serviceAreasTitle = 'Service areas';
  static const String mapAreasHint = 'Service coverage (preview)';
  static const String operatingHoursTitle = 'Operating hours';
  static const String teamRolesTitle = 'Team & permissions';
  static const String notificationPrefsTitle = 'Notifications';
  static const String helpCenterTitle = 'Help center';
  static const String chatSupport = 'Chat with support';
  static const String callSupport = 'Call support (9–6)';

  // Web tools
  static const String webToolsTitle = 'Business tools';
  static const String webToolsSubtitle = 'Desktop-friendly features';
  static const String webBulkCsv = 'Bulk CSV import / export';
  static const String webBulkCsvDesc = 'Upload or download datasets with date filters.';
  static const String webSplitView = 'Split screen — order + chat';
  static const String webSplitViewDesc = 'Side-by-side on large screens.';
  static const String webPrint = 'Printable job sheets';
  static const String webPrintDesc = 'A4 or 80mm thermal layouts.';
  static const String webAnalytics = 'Advanced analytics';
  static const String webAnalyticsDesc = 'Cohort, heatmaps, profitability.';
  static const String webShortcuts = 'Keyboard shortcuts';
  static const String webShortcutsDesc = 'Accept, reject, new item — see Help.';

  // Misc
  static const String versionLabel = 'Version';
  static const String labelSeparator = ' · ';

  static String threadLabel(String id) => 'Thread $id';

  static String timeRange(String open, String close) => '$open – $close';
}
