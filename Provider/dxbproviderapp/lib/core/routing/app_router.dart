import 'package:go_router/go_router.dart';

import '../../features/account_status/presentation/account_status_page.dart';
import '../../features/analytics/presentation/analytics_operational_page.dart';
import '../../features/analytics/presentation/analytics_overview_page.dart';
import '../../features/analytics/presentation/analytics_vertical_page.dart';
import '../../features/catalog/presentation/catalog_food_page.dart';
import '../../features/catalog/presentation/catalog_hub_page.dart';
import '../../features/catalog/presentation/catalog_simple_vertical_page.dart';
import '../../features/customers/presentation/customer_detail_page.dart';
import '../../features/customers/presentation/customers_list_page.dart';
import '../../features/dashboard/presentation/dashboard_page.dart';
import '../../features/earnings/presentation/bank_page.dart';
import '../../features/earnings/presentation/earnings_page.dart';
import '../../features/earnings/presentation/payouts_page.dart';
import '../../features/inbox/presentation/attachments_page.dart';
import '../../features/inbox/presentation/chat_page.dart';
import '../../features/inbox/presentation/inbox_page.dart';
import '../../features/onboarding/presentation/login_page.dart';
import '../../features/onboarding/presentation/tutorial_page.dart';
import '../../features/onboarding/presentation/register_business_page.dart';
import '../../features/onboarding/presentation/register_documents_page.dart';
import '../../features/onboarding/presentation/welcome_page.dart';
import '../../features/orders/presentation/order_detail_page.dart';
import '../../features/orders/presentation/orders_list_page.dart';
import '../../features/orders/presentation/proof_upload_page.dart';
import '../../features/orders/presentation/rider_assign_page.dart';
import '../../features/reviews/presentation/review_detail_page.dart';
import '../../features/reviews/presentation/reviews_list_page.dart';
import '../../features/settings/presentation/account_hub_page.dart';
import '../../features/settings/presentation/extra_account_pages.dart';
import '../../features/shell/main_shell.dart';
import '../../features/splash/presentation/splash_page.dart';
import '../../features/session/domain/account_status.dart';
import '../../features/session/presentation/session_cubit.dart';
import '../di/service_locator.dart';
import 'router_refresh.dart';

GoRouter createAppRouter() {
  final session = sl<SessionCubit>();
  final refresh = sl<RouterRefresh>();

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: refresh,
    redirect: (context, state) {
      final s = session.state;
      final loc = state.matchedLocation;

      if (!s.hydrated) {
        if (loc != '/splash') return '/splash';
        return null;
      }

      final publicUnauth = loc == '/splash' ||
          loc == '/tutorial' ||
          loc == '/welcome' ||
          loc == '/login' ||
          loc.startsWith('/register') ||
          loc.startsWith('/account-status');

      if (!s.isLoggedIn) {
        if (s.hasSeenTutorial && loc == '/tutorial') {
          return '/login';
        }
        if (s.hasSeenTutorial && loc == '/welcome') {
          return '/login';
        }
        if (!s.hasSeenTutorial) {
          if (loc == '/splash' || loc == '/tutorial') return null;
          return '/tutorial';
        }
        if (publicUnauth) return null;
        return '/login';
      }

      if (s.isLoggedIn && s.accountStatus != AccountStatus.approved) {
        final target = '/account-status/${s.accountStatus.jsonName}';
        if (loc.startsWith('/account-status')) return null;
        return target;
      }

      if (s.isLoggedIn && s.accountStatus == AccountStatus.approved) {
        if (loc == '/splash' ||
            loc == '/welcome' ||
            loc == '/login' ||
            loc == '/tutorial' ||
            loc.startsWith('/register')) {
          return '/home';
        }
        if (loc.startsWith('/account-status')) return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (c, s) => const SplashPage()),
      GoRoute(path: '/tutorial', builder: (c, s) => const TutorialPage()),
      GoRoute(path: '/welcome', builder: (c, s) => const WelcomePage()),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(path: '/register/business', builder: (c, s) => const RegisterBusinessPage()),
      GoRoute(path: '/register/documents', builder: (c, s) => const RegisterDocumentsPage()),
      GoRoute(
        path: '/account-status/:status',
        builder: (c, s) {
          final st = AccountStatus.fromJson(s.pathParameters['status']);
          return AccountStatusPage(status: st);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (c, s) => const DashboardPage(),
                routes: [
                  GoRoute(
                    path: 'customers',
                    builder: (c, s) => const CustomersListPage(),
                    routes: [
                      GoRoute(
                        path: ':id',
                        builder: (c, s) => CustomerDetailPage(id: s.pathParameters['id']!),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/orders',
                builder: (c, s) => const OrdersListPage(),
                routes: [
                  GoRoute(
                    path: ':orderId',
                    builder: (c, s) => OrderDetailPage(orderId: s.pathParameters['orderId']!),
                    routes: [
                      GoRoute(
                        path: 'proof',
                        builder: (c, s) => ProofUploadPage(orderId: s.pathParameters['orderId']!),
                      ),
                      GoRoute(
                        path: 'rider',
                        builder: (c, s) => RiderAssignPage(orderId: s.pathParameters['orderId']!),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/catalog',
                builder: (c, s) => const CatalogHubPage(),
                routes: [
                  GoRoute(path: 'food', builder: (c, s) => const CatalogFoodPage()),
                  GoRoute(
                    path: 'availability',
                    builder: (c, s) => const CatalogSimpleVerticalPage(verticalKey: 'availability'),
                  ),
                  GoRoute(
                    path: 'laundry',
                    builder: (c, s) => const CatalogSimpleVerticalPage(verticalKey: 'laundry'),
                  ),
                  GoRoute(
                    path: 'cars',
                    builder: (c, s) => const CatalogSimpleVerticalPage(verticalKey: 'cars'),
                  ),
                  GoRoute(
                    path: 'hotels',
                    builder: (c, s) => const CatalogSimpleVerticalPage(verticalKey: 'hotels'),
                  ),
                  GoRoute(
                    path: 'marketplace',
                    builder: (c, s) => const CatalogSimpleVerticalPage(verticalKey: 'marketplace'),
                  ),
                  GoRoute(
                    path: 'home_services',
                    builder: (c, s) => const CatalogSimpleVerticalPage(verticalKey: 'home_services'),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/inbox',
                builder: (c, s) => const InboxPage(),
                routes: [
                  GoRoute(
                    path: 'chat/:threadId',
                    builder: (c, s) => ChatPage(threadId: s.pathParameters['threadId']!),
                    routes: [
                      GoRoute(
                        path: 'attachments',
                        builder: (c, s) => AttachmentsPage(threadId: s.pathParameters['threadId']!),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/account',
                builder: (c, s) => const AccountHubPage(),
                routes: [
                  GoRoute(path: 'earnings', builder: (c, s) => const EarningsPage()),
                  GoRoute(path: 'payouts', builder: (c, s) => const PayoutsPage()),
                  GoRoute(path: 'bank', builder: (c, s) => const BankPage()),
                  GoRoute(path: 'analytics/overview', builder: (c, s) => const AnalyticsOverviewPage()),
                  GoRoute(path: 'analytics/vertical', builder: (c, s) => const AnalyticsVerticalPage()),
                  GoRoute(path: 'analytics/operational', builder: (c, s) => const AnalyticsOperationalPage()),
                  GoRoute(
                    path: 'reviews',
                    builder: (c, s) => const ReviewsListPage(),
                    routes: [
                      GoRoute(
                        path: ':reviewId',
                        builder: (c, s) => ReviewDetailPage(reviewId: s.pathParameters['reviewId']!),
                      ),
                    ],
                  ),
                  GoRoute(path: 'settings/profile', builder: (c, s) => const BusinessProfilePage()),
                  GoRoute(path: 'settings/service-areas', builder: (c, s) => const ServiceAreasPage()),
                  GoRoute(path: 'settings/hours', builder: (c, s) => const OperatingHoursPage()),
                  GoRoute(path: 'settings/team', builder: (c, s) => const TeamRolesPage()),
                  GoRoute(path: 'settings/notifications', builder: (c, s) => const NotificationPrefsPage()),
                  GoRoute(path: 'help', builder: (c, s) => const HelpCenterPage()),
                  GoRoute(path: 'web-tools', builder: (c, s) => const WebToolsPage()),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
