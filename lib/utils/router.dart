import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// --- Imports (تأكد من مطابقة الأسماء للملفات عندك) ---
import '../features/donations_presentation/donation_details_screen.dart';
import '../features/donations_presentation/history_screen.dart';
import '../features/donations_presentation/notifications_screen.dart'; // <--- السطر ده كان ناقص

import '../features/home_presentation/splash_screen.dart';
import '../features/home_presentation/login_screen.dart';
import '../features/home_presentation/register_screen.dart';
import '../features/search_presentation/main_wrapper.dart';
import '../features/home_presentation/home_screen.dart';
import '../features/search_presentation/search_screen.dart';
import '../features/donations_presentation/profile_screen.dart';
import '../features/donations_presentation/add_donation_screen.dart';
import '../features/donations_presentation/amount_picker_screen.dart';
import '../features/donations_presentation/category_screen.dart';
import '../features/donations_presentation/payment_method_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      // شاشات ما قبل الدخول
      GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),

      // الشاشات التي تحتوي على Bottom Navigation Bar
      ShellRoute(
        builder: (context, state, child) => MainWrapper(child: child),
        routes: [
          GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          GoRoute(path: '/search', builder: (context, state) => const SearchScreen()),
          GoRoute(path: '/history', builder: (context, state) => const HistoryScreen()),
          GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
          // يفضل وضع الإشعارات هنا إذا كنت تريد بقاء القائمة السفلية ظاهرة
          GoRoute(path: '/notifications', builder: (context, state) => const NotificationsScreen()),
        ],
      ),

      // مسارات عملية التبرع (تظهر كشاشات كاملة بدون القائمة السفلية)
      GoRoute(path: '/add-donation', builder: (context, state) => const AddDonationScreen()),

      GoRoute(
        path: '/select-category/:name',
        builder: (context, state) => CategoryScreen(categoryName: state.pathParameters['name'] ?? 'Category'),
      ),

      GoRoute(
        path: '/donation-details/:category',
        builder: (context, state) {
          final category = state.pathParameters['category'] ?? 'General';
          return DonationDetailsScreen(category: category);
        },
      ),

      GoRoute(path: '/amount-picker', builder: (context, state) => const AmountPickerScreen()),
      GoRoute(path: '/payment-method', builder: (context, state) => const PaymentMethodScreen()),
    ],
  );
});