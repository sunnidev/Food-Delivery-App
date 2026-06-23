import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import 'order_cancelled_screen.dart';

class CancelOrderScreen extends StatefulWidget {
  static const String routeName = '/cancel-order';

  const CancelOrderScreen({super.key});

  @override
  State<CancelOrderScreen> createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  String? _selectedReason;
  final TextEditingController _otherReasonController = TextEditingController();

  final List<String> cancelReasons = [
    'Changed my mind about this order',
    'Waiting time is too long',
    'Price is not reasonable',
    'Items are not available',
    'I want to order from another restaurant',
  ];

  @override
  void dispose() {
    _otherReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSplash,
      body: SafeArea(
        child: Column(
          children: [
            // Yellow Header
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
                      'Cancel Order',
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

            // White rounded sheet with form
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: Container(
                  color: AppColors.white,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Description
                          Text(
                            'We\'d love to know why you\'re canceling this order. Your feedback helps us improve our service and provide better experience.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Cancel Reasons
                          ...cancelReasons.map((reason) {
                            return _buildReasonOption(reason);
                          }).toList(),

                          const SizedBox(height: 20),

                          // Others Section
                          Text(
                            'Others',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Text Input
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.backgroundSplash.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _otherReasonController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                hintText: 'Other reason...',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(12),
                              ),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Submit Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _handleSubmit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReasonOption(String reason) {
    final isSelected = _selectedReason == reason;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedReason = reason;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  reason,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : Colors.grey[300]!,
                    width: 2,
                  ),
                  color: isSelected ? AppColors.primary : Colors.transparent,
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        size: 14,
                        color: AppColors.white,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_selectedReason == null && _otherReasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a reason or provide other details'),
          backgroundColor: AppColors.primary,
        ),
      );
      return;
    }

    // Get arguments from route
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final onOrderCancelled = arguments?['onOrderCancelled'] as VoidCallback?;

    // Navigate to success screen with callback
    Navigator.pushNamed(
      context,
      OrderCancelledScreen.routeName,
      arguments: {'onOrderCancelled': onOrderCancelled},
    );
  }
}
