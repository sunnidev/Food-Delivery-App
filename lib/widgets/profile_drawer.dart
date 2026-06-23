import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import '../screens/my_profile_screen.dart';
import '../screens/my_orders_screen.dart';
import '../screens/delivery_address_screen.dart';
import '../screens/payment_methods_screen.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(80),
        bottomLeft: Radius.circular(80),
      ),
      child: Drawer(
        child: Container(
          color: AppColors.primary,
          child: Column(
            children: [
              const SizedBox(height: 50),
              
              // User Info Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile with image
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.backgroundSplash,
                              width: 3,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/profile.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person,
                                  color: AppColors.primary,
                                  size: 40,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Smith',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Loremipsum@email.com',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.white.withValues(alpha: 0.9),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              Divider(
                color: AppColors.white.withValues(alpha: 0.3),
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              
              // Menu Items
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _DrawerMenuItem(
                      icon: Icons.shopping_bag_outlined,
                      label: 'My Orders',
                      onTap: () {
                        Navigator.pushNamed(context, MyOrdersScreen.routeName);
                      },
                    ),
                    _DrawerMenuItem(
                      icon: Icons.person_outline,
                      label: 'My Profile',
                      onTap: () {
                        Navigator.pushNamed(context, MyProfileScreen.routeName);
                      },
                    ),                    
                    _DrawerMenuItem(
                      icon: Icons.location_on_outlined,
                      label: 'Delivery Address',
                      onTap: () {
                        Navigator.pushNamed(context, DeliveryAddressScreen.routeName);
                      },
                    ),
                    _DrawerMenuItem(
                      icon: Icons.payment_outlined,
                      label: 'Payment Methods',
                      onTap: () {
                        Navigator.pushNamed(context, PaymentMethodsScreen.routeName);
                      },
                    ),
                    _DrawerMenuItem(
                      icon: Icons.call_outlined,
                      label: 'Contact Us',
                      onTap: () {},
                    ),
                    _DrawerMenuItem(
                      icon: Icons.help_outline,
                      label: 'Help & FAQs',
                      onTap: () {},
                    ),
                    _DrawerMenuItem(
                      icon: Icons.settings_outlined,
                      label: 'Settings',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              
              Divider(
                color: AppColors.white.withValues(alpha: 0.3),
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              
              // Logout Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: _DrawerMenuItem(
                  icon: Icons.logout,
                  label: 'Log Out',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          onTap();
        },
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
