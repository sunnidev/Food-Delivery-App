import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../widgets/brand_button.dart';
import '../data/onboarding_data.dart';
import '../config/strings.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Use data-driven onboardingItems from data/onboarding_data.dart
  final List<OnboardingItemData> _items = onboardingItems;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_currentPage == _items.length - 1) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _skip() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSplash,
      // Allow content to extend into the bottom system inset so the white
      // sheet covers the whole bottom area (hides yellow background behind
      // the system navigation/home indicator).
      body: SafeArea(
        bottom: false,
        child: PageView.builder(
          controller: _pageController,
          itemCount: _items.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            final item = _items[index];
            // Move the white sheet lower so it starts further down the screen
            // (smaller visible white area at top). Adjust this factor if needed.
            final sheetTop = MediaQuery.of(context).size.height * 0.60;

            return Stack(
              children: [
                // Full-screen image
                Positioned.fill(
                  child: Image.asset(
                    item.imageAsset,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
                ),

                // Skip button top-right over image (hidden on last page)
                if (index != _items.length - 1)
                  Positioned(
                    top: 12,
                    right: 16,
                    child: GestureDetector(
                      onTap: _skip,
                      child: Text(
                        Strings.skip,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                // White rounded sheet from bottom
                Positioned(
                  left: 0,
                  right: 0,
                  top: sheetTop,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            item.icon,
                            size: 28,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Text(
                              item.subtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primary.withOpacity(0.7),
                                fontSize: 15,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _items.length,
                            (dotIndex) {
                              final isActive = dotIndex == _currentPage;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                width: isActive ? 28 : 10,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: isActive ? AppColors.primary : AppColors.primary.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 14),
                        BrandButton(
                          label: _currentPage == _items.length - 1 ? Strings.getStarted : Strings.next,
                          onPressed: _goNext,
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

