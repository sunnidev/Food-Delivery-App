import 'dart:async';

import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import '../config/strings.dart';
import '../screens/intro_screen.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      imageAsset: 'assets/logo/logo1.png',
      backgroundColor: AppColors.backgroundSplash,
      title: Strings.appName,
      titleWidget: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'YUM',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
            TextSpan(
              text: 'QUICK',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
          style: const TextStyle(fontSize: 36),
        ),
        textAlign: TextAlign.center,
      ),
      subtitle: Strings.splashSubtitle,
      textColor: AppColors.primary,
    );
  }
}
