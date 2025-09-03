import 'package:go_router/go_router.dart';

// Import your screens
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/transactions/presentation/transactions_analytics_screen.dart';
import '../../features/deposit/dashboard/deposit_page.dart';
import '../../features/transfer/presentation/transfer_page.dart';
import '../../features/withdrawals/presentation/withdrawal_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import 'package:mfs_mobile/features/balance/balance_page.dart';
import 'package:mfs_mobile/features/loans/loans_page.dart';
import 'package:mfs_mobile/features/savings/savings_page.dart';
import 'package:mfs_mobile/features/credit/credit_score_page.dart';
import 'package:mfs_mobile/features/profile/profile_settings_screen.dart';


class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/dashboard',
          name: 'dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/transactions',
          name: 'transactions',
          builder: (context, state) => const TransactionsAnalyticsScreen(),
        ),
        GoRoute(
          path: '/deposit',
          name: 'deposit',
          builder: (context, state) => const DepositPage(),
        ),
        GoRoute(
          path: '/transfer',
          name: 'transfer',
          builder: (context, state) => const TransferPage(),
        ),
        GoRoute(
          path: '/withdraw',
          name: 'withdraw',
          builder: (context, state) => const WithdrawalScreen(),
        ),
        GoRoute(
          path: '/notifications',
          name: 'notifications',
          builder: (context, state) => const NotificationsScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfileSettingsScreen(),
        ),
        GoRoute(
          path: '/balance', 
          name: 'balance', 
          builder: (context, state) => const BalancePage()
        ),
        GoRoute(
          path: '/loans', 
          name: 'loans', 
          builder: (context, state) => const LoansPage()
        ),
        GoRoute(
          path: '/savings', 
          name: 'savings', 
          builder: (context, state) => const SavingsPage()
        ),
        GoRoute(
          path: '/credit-score', 
          name: 'credit-score', 
          builder: (context, state) => const CreditScorePage()
        ),
      ],
    );
  }
}