import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mfs_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:mfs_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:mfs_mobile/features/credit/presentation/screens/credit_score_page.dart';
import 'package:mfs_mobile/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:mfs_mobile/features/dashboard/presentation/screens/home_screen.dart';
import 'package:mfs_mobile/features/loans/presentation/screens/loan_repayment_page.dart';
import 'package:mfs_mobile/features/loans/presentation/screens/loans_page.dart';
import 'package:mfs_mobile/features/profile/presentation/screens/profile_page.dart';
import 'package:mfs_mobile/features/saving/presentation/screens/savings_page.dart';
import 'package:mfs_mobile/features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      // Splash Screen
      GoRoute(
        path: '/splash',
        name: 'splash',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),

      // Home Screen
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),

      // Dashboard
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: DashboardScreen(),
        ),
        routes: [
          // Profile Screen (nested under dashboard)
          GoRoute(
            path: 'profile',
            name: 'profile',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: ProfilePage(),
            ),
          ),
          // Nested routes for dashboard sections
          GoRoute(
            path: 'savings',
            name: 'savings',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: SavingsPage(),
            ),
          ),
          GoRoute(
            path: 'loans',
            name: 'loans',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: LoansPage(),
            ),
            routes: [
              // Nested route for loan repayment
              GoRoute(
                path: 'repayment',
                name: 'loan_repayment',
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: LoanRepaymentPage(),
                ),
              ),
            ],
          ),
          // Credit score route
          GoRoute(
            path: 'credit-score',
            name: 'credit_score',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: CreditScorePage(),
            ),
          ),
        ],
      ),

      // Login
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),

      // Register
      GoRoute(
        path: '/register',
        name: 'register',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const RegisterScreen(),
        ),
      ),

      // Redirect root to splash
      GoRoute(
        path: '/',
        redirect: (context, state) => '/splash',
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Route not found: ${state.uri.path}'),
      ),
    ),
  );

  // Navigation helper methods
  static void goToHome(BuildContext context) {
    context.goNamed('home');
  }

  static void goToLogin(BuildContext context) {
    context.goNamed('login');
  }

  static void goToRegister(BuildContext context) {
    context.goNamed('register');
  }

  static void goToDashboard(BuildContext context) {
    context.goNamed('dashboard');
  }

  static void goToProfile(BuildContext context) {
    context.go('/dashboard/profile');
  }
}