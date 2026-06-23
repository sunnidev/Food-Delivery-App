import 'package:flutter/material.dart';

import 'colors/app_colors.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/my_orders_screen.dart';
import 'screens/cancel_order_screen.dart';
import 'screens/order_cancelled_screen.dart';
import 'screens/leave_review_screen.dart';
import 'screens/my_profile_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YumQuick',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        MyOrdersScreen.routeName: (context) => const MyOrdersScreen(),
        CancelOrderScreen.routeName: (context) => const CancelOrderScreen(),
        OrderCancelledScreen.routeName: (context) => const OrderCancelledScreen(),
        LeaveReviewScreen.routeName: (context) => const LeaveReviewScreen(),
        MyProfileScreen.routeName: (context) => const MyProfileScreen(),
      },
    );
  }
}
