import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import '../screens/home_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          // Home button always navigates to home screen
          if (index == 0) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            );
          } else {
            // Call the onTap callback for other tabs if provided
            onTap?.call(index);
          }
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.white.withValues(alpha: 0.5),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 24),
            activeIcon: Icon(Icons.home, size: 24),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_outlined, size: 24),
            activeIcon: Icon(Icons.restaurant, size: 24),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline, size: 24),
            activeIcon: Icon(Icons.favorite, size: 24),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined, size: 24),
            activeIcon: Icon(Icons.description, size: 24),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.headphones_outlined, size: 24),
            activeIcon: Icon(Icons.headphones, size: 24),
            label: '',
          ),
        ],
      ),
    );
  }
}
