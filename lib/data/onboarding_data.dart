import 'package:flutter/material.dart';

class OnboardingItemData {
  final String imageAsset;
  final String title;
  final String subtitle;
  final IconData icon;

  const OnboardingItemData({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

const List<OnboardingItemData> onboardingItems = [
  OnboardingItemData(
    imageAsset: 'assets/images/onboarding1.png',
    title: 'Order For Food',
    subtitle: 'Browse restaurants, select your favorite meals, and place your order in seconds.',
    icon: Icons.restaurant_menu,
  ),
  OnboardingItemData(
    imageAsset: 'assets/images/onboarding2.png',
    title: 'Easy Payment',
    subtitle: 'Pay securely with cards or wallets. Fast checkout keeps your order moving.',
    icon: Icons.credit_card,
  ),
  OnboardingItemData(
    imageAsset: 'assets/images/onboarding3.png',
    title: 'Fast Delivery',
    subtitle: 'Get your food delivered hot and quick from nearby restaurants.',
    icon: Icons.delivery_dining,
  ),
];
