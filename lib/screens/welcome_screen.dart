import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import '../config/strings.dart';
import '../screens/intro_screen.dart';
import '../screens/onboarding_screen.dart';
import '../widgets/brand_button.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome';

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      imageAsset: 'assets/logo/logo2.png',
      backgroundColor: AppColors.backgroundWelcome,
      title: Strings.appName,
      titleWidget: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'YUM',
              style: TextStyle(
                color: AppColors.secondary,
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
      subtitle: Strings.welcomeSubtitle,
      textColor: AppColors.white,
      footer: Column(
        children: [
          BrandButton(
            label: Strings.logIn,
            onPressed: () {
              Navigator.pushNamed(context, OnboardingScreen.routeName);
            },
          ),
          const SizedBox(height: 14),
          BrandButton(
            label: Strings.signUp,
            onPressed: () {
              Navigator.pushNamed(context, OnboardingScreen.routeName);
            },
            filled: false,
          ),
        ],
      ),
    );
  }
}
