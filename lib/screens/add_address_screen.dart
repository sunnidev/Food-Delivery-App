import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../colors/app_colors.dart';
import '../models/address_model.dart';
import '../services/address_service.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class AddAddressScreen extends StatefulWidget {
  static const String routeName = '/add-address';

  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
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
                      'Add New Address',
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
                          const SizedBox(height: 16),

                          // Home Icon
                          Center(
                            child: Icon(
                              Icons.home_outlined,
                              size: 60,
                              color: AppColors.primary,
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Name Field
                          Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildTextField(_nameController, 'Anna House'),

                          const SizedBox(height: 20),

                          // Address Field
                          Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildTextField(
                            _addressController,
                            '778 Locust View Drive\nOaklanda, CA',
                            maxLines: 3,
                          ),

                          const SizedBox(height: 40),

                          // Apply Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _handleAddAddress,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Text(
                                'Apply',
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
      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundSplash.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }

  Future<void> _handleAddAddress() async {
    if (_nameController.text.isEmpty || _addressController.text.isEmpty) {
      _showErrorSnackBar('Please fill all fields');
      return;
    }

    try {
      print('=== Starting to add address ===');
      print('Name: ${_nameController.text}');
      print('Address: ${_addressController.text}');

      // Create new address model
      final newAddress = AddressModel(
        id: const Uuid().v4(),
        name: _nameController.text,
        address: _addressController.text,
      );

      print('Address model created with ID: ${newAddress.id}');
      print('Address JSON: ${newAddress.toJsonString()}');

      // Save to local storage
      print('Attempting to save to SharedPreferences...');
      final success = await AddressService.addAddress(newAddress);

      print('Save result: $success');

      if (success) {
        print('✓ Address saved successfully!');
        _showSuccessSnackBar('Address added successfully');

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pop(context, true); // Return true to refresh
          }
        });
      } else {
        print('✗ AddressService returned false');
        _showErrorSnackBar('Failed to save address to storage');
      }
    } catch (e) {
      print('✗ Exception caught: $e');
      print('Error type: ${e.runtimeType}');
      _showErrorSnackBar('Error: $e');
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
