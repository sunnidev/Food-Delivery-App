import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import 'cancel_order_screen.dart';
import 'leave_review_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class MyOrdersScreen extends StatefulWidget {
  static const String routeName = '/my-orders';

  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  String _selectedTab = 'Active';
  int _selectedBottomIndex = 0;

  final List<String> tabs = ['Active', 'Completed', 'Cancelled'];

  late List<Map<String, dynamic>> activeOrders;
  late List<Map<String, dynamic>> completedOrders;
  late List<Map<String, dynamic>> cancelledOrders;
  
  // Track which orders have been reviewed
  final Set<String> reviewedOrders = {};

  @override
  void initState() {
    super.initState();
    activeOrders = [
      {
        'name': 'Strawberry shake',
        'date': '29 Nov, 01:20 pm',
        'price': '\$20.00',
        'items': '2 items',
        'image': 'assets/images/bestseller1.png',
      },
      {
        'name': 'Burger Combo',
        'date': '28 Nov, 02:45 pm',
        'price': '\$15.50',
        'items': '3 items',
        'image': 'assets/images/bestseller3.png',
      },
    ];
    completedOrders = [
      {
        'name': 'Chicken Curry',
        'date': '29 Nov, 01:20 pm',
        'price': '\$50.00',
        'items': '2 items',
        'image': 'assets/images/bestseller2.png',
      },
      {
        'name': 'Bean and Vegetable Burger',
        'date': '10 Nov, 06:05 pm',
        'price': '\$50.00',
        'items': '2 items',
        'image': 'assets/images/bestseller3.png',
      },
      {
        'name': 'Coffee Latte',
        'date': '10 Nov, 08:30 am',
        'price': '\$8.00',
        'items': '1 item',
        'image': 'assets/images/Drinks.png',
      },
      {
        'name': 'Strawberry Cheesecake',
        'date': '03 Oct, 03:40 pm',
        'price': '\$22.00',
        'items': '2 items',
        'image': 'assets/images/Desserts.png',
      },
    ];
    cancelledOrders = [];
  }

  List<Map<String, dynamic>> getOrdersByTab() {
    switch (_selectedTab) {
      case 'Active':
        return activeOrders;
      case 'Completed':
        return completedOrders;
      case 'Cancelled':
        return cancelledOrders;
      default:
        return activeOrders;
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = getOrdersByTab();

    return Scaffold(
      backgroundColor: AppColors.backgroundSplash,
      body: SafeArea(
        child: Column(
          children: [
            // Yellow Header with Title
            Container(
              color: AppColors.backgroundSplash,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'My Orders',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // White rounded sheet
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: Container(
                  color: AppColors.white,
                  child: Column(
                    children: [
                      // Tab Buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Row(
                          children: tabs.map((tab) {
                            final isSelected = _selectedTab == tab;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedTab = tab;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.primary.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      tab,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? AppColors.white
                                            : AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList()
                              .expand((widget) =>
                                  [widget, const SizedBox(width: 8)])
                              .toList()
                              .sublist(0, tabs.length * 2 - 1),
                        ),
                      ),

                      // Orders List or Empty State
                      if (orders.isEmpty)
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Empty Icon
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary.withValues(alpha: 0.1),
                                  ),
                                  child: Icon(
                                    Icons.receipt_long,
                                    size: 60,
                                    color: AppColors.primary.withValues(alpha: 0.4),
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Empty Message
                                Text(
                                  'You don\'t have any\n${_selectedTab.toLowerCase()} orders at this\ntime',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              return _buildOrderCard(orders[index], index);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedBottomIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, int index) {
    // Determine which list the order belongs to
    bool isActive = activeOrders.contains(order);
    bool isCompleted = completedOrders.contains(order);
    bool isCancelled = cancelledOrders.contains(order);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Order Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.grey[300],
                child: Image.asset(
                  order['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      color: Colors.grey[400],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Order Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          order['name'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        order['price'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Date
                  Text(
                    order['date'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Items count
                  Text(
                    order['items'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // Status for Completed and Cancelled
                  if (isCompleted || isCancelled) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isCancelled ? 'Order cancelled' : 'Order delivered',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 8),

                  // Buttons based on status
                  if (isActive)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                CancelOrderScreen.routeName,
                                arguments: {
                                  'order': order,
                                  'onOrderCancelled': () {
                                    setState(() {
                                      activeOrders.removeAt(index);
                                      cancelledOrders.add(order);
                                      _selectedTab = 'Cancelled';
                                    });
                                  },
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'Cancel Order',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Track Driver',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else if (isCompleted)
                    Row(
                      children: [
                        if (!reviewedOrders.contains(order['name']))
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  LeaveReviewScreen.routeName,
                                  arguments: {
                                    'order': order,
                                    'onReviewSubmitted': () {
                                      setState(() {
                                        reviewedOrders.add(order['name']);
                                      });
                                    },
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'Leave a review',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (reviewedOrders.contains(order['name']))
                          const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Order Again',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else if (isCancelled)
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Order Again',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
