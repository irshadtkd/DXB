import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/car/presentation/car_book_screen.dart';
import '../../features/car/presentation/car_confirm_screen.dart';
import '../../features/car/presentation/car_detail_screen.dart';
import '../../features/car/presentation/car_home_screen.dart';
import '../../features/chat/presentation/chat_screen.dart';
import '../../features/checkout/presentation/checkout_screen.dart';
import '../../features/explore/presentation/explore_screen.dart';
import '../../features/food/presentation/food_screen.dart';
import '../../features/help/presentation/help_screen.dart';
import '../../features/home_services/presentation/hs_book_screen.dart';
import '../../features/home_services/presentation/hs_complete_screen.dart';
import '../../features/home_services/presentation/hs_detail_screen.dart';
import '../../features/home_services/presentation/hs_home_screen.dart';
import '../../features/home_services/presentation/hs_track_screen.dart';
import '../../features/hub/presentation/cubit/hub_cubit.dart';
import '../../features/hub/presentation/hub_screen.dart';
import '../../features/laundry/presentation/laundry_home_screen.dart';
import '../../features/laundry/presentation/laundry_schedule_screen.dart';
import '../../features/laundry/presentation/laundry_summary_screen.dart';
import '../../features/laundry/presentation/laundry_tracking_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/orders/presentation/cubit/orders_cubit.dart';
import '../../features/orders/presentation/order_history_screen.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/review/presentation/review_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/tracking/presentation/tracking_screen.dart';
import '../../features/wallet/presentation/add_money_screen.dart';
import '../../features/wallet/presentation/wallet_screen.dart';
import '../di/service_locator.dart';
import 'main_shell.dart';
import 'route_paths.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRouter() {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RoutePaths.splash,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (_, __) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.hub,
                builder: (_, __) => BlocProvider(
                  create: (_) => HubCubit(sl())..load(),
                  child: const HubScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.ordersTab,
                builder: (_, __) => BlocProvider(
                  create: (_) => OrdersCubit(sl())..load(),
                  child: const OrderHistoryScreen(embeddedInShell: true),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.explore,
                builder: (_, __) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.profileTab,
                builder: (_, __) => BlocProvider(
                  create: (_) => ProfileCubit(sl())..load(),
                  child: const ProfileScreen(embeddedInShell: true),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RoutePaths.food,
        builder: (_, __) => const FoodScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RoutePaths.laundry,
        builder: (_, __) => const LaundryHomeScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RoutePaths.laundrySchedule,
        builder: (_, __) => const LaundryScheduleScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RoutePaths.laundrySummary,
        builder: (_, __) => const LaundrySummaryScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '${RoutePaths.laundryTracking}/:orderId',
        builder: (_, st) => LaundryTrackingScreen(orderId: st.pathParameters['orderId'] ?? ''),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RoutePaths.car,
        builder: (_, __) => const CarHomeScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/car/:vehicleId',
        builder: (_, st) => CarDetailScreen(vehicleId: st.pathParameters['vehicleId'] ?? ''),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/car/:vehicleId/book',
        builder: (_, st) => CarBookScreen(vehicleId: st.pathParameters['vehicleId'] ?? ''),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/car/:vehicleId/confirm',
        builder: (_, st) => CarConfirmScreen(vehicleId: st.pathParameters['vehicleId'] ?? ''),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/tracking/:orderId',
        builder: (_, st) => TrackingScreen(orderId: st.pathParameters['orderId'] ?? ''),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/checkout/:orderId',
        builder: (_, st) => CheckoutScreen(orderId: st.pathParameters['orderId'] ?? ''),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RoutePaths.homeServices,
        builder: (_, __) => const HsHomeScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/home-services/:serviceId',
        builder: (_, st) => HsDetailScreen(serviceId: st.pathParameters['serviceId'] ?? 'electrician'),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RoutePaths.homeServiceBook,
        builder: (_, __) => const HsBookScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/home-services/track/:orderId',
        builder: (_, st) => HsTrackScreen(orderId: st.pathParameters['orderId'] ?? ''),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/home-services/complete/:orderId',
        builder: (_, st) => HsCompleteScreen(orderId: st.pathParameters['orderId'] ?? ''),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RoutePaths.wallet,
        builder: (_, __) => const WalletScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RoutePaths.walletAdd,
        builder: (_, __) => const AddMoneyScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RoutePaths.notifications,
        builder: (_, __) => const NotificationsScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/chat/:threadId',
        builder: (_, st) => ChatScreen(threadId: st.pathParameters['threadId'] ?? 'default'),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/review/:orderId',
        builder: (_, st) => ReviewScreen(orderId: st.pathParameters['orderId'] ?? ''),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RoutePaths.help,
        builder: (_, __) => const HelpScreen(),
      ),
    ],
  );
}
