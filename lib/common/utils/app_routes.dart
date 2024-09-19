
import 'package:fashion_app/src/auth/views/login_screen.dart';
import 'package:fashion_app/src/auth/views/registration_screen.dart';
import 'package:fashion_app/src/categories/views/categories_screen.dart';
import 'package:fashion_app/src/categories/views/category_screen.dart';
import 'package:fashion_app/src/checkout/views/checkout_screen.dart';
import 'package:fashion_app/src/entrypoint/views/entrypoint.dart';
import 'package:fashion_app/src/notification/views/notification_screen.dart';
import 'package:fashion_app/src/products/views/product_screen.dart';
import 'package:fashion_app/src/profile/views/orders_screen.dart';
import 'package:fashion_app/src/profile/views/policy_screen.dart';
import 'package:fashion_app/src/addresses/views/shipping_address_screen.dart';
import 'package:fashion_app/src/search/views/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../src/onboarding/views/onboarding_screen.dart';
import '../../src/splash_screen/views/splash_screen.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


final GoRouter _router = GoRouter(
   navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) =>  const AppEntryPoint(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnBoardingScreen(),
    ),
    // GoRoute(
    //   path: '/review',
    //   builder: (context, state) => const ReviewsPage(),
    // ),
    GoRoute(
      path: '/policy',
      builder: (context, state) => const PolicyScreen(),
    ),
    // GoRoute(
    //   path: '/verification',
    //   builder: (context, state) => const VerificationPage(),
    // ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    // GoRoute(
    //   path: '/help',
    //   builder: (context, state) => const HelpCenterPage(),
    // ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegistrationScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoriesScreen(),
    ),
     GoRoute(
      path: '/category',
      builder: (context, state) => const CategoryScreen(),
    ),
    //
    // GoRoute(
    //   path: '/addaddress',
    //   builder: (context, state) => const AddAddress(),
    // ),
    //
    GoRoute(
      path: '/addresses',
      builder: (context, state) => const ShippingAddressScreen(),
    ),
    //
     GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    //
    //  GoRoute(
    //   path: '/tracking',
    //   builder: (context, state) => const TrackOrderPage(),
    // ),
    //
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
    //
    //   GoRoute(
    //   path: '/successful',
    //   builder: (context, state) => const SuccessfulPayment(),
    // ),
    //
    //   GoRoute(
    //   path: '/failed',
    //   builder: (context, state) => const FailedPayment(),
    // ),
    //
    GoRoute(
      path: '/product/:id',
      builder: (BuildContext context, GoRouterState state) {
        final productId = state.pathParameters['id'];
        return ProductScreen(productId: productId.toString());
      },
    ),
  ],
);

GoRouter get router => _router;
