import 'package:shared_preferences/shared_preferences.dart';
import '../models/address_model.dart';

class AddressService {
  static const String _addressKey = 'delivery_addresses';

  // Get all addresses
  static Future<List<AddressModel>> getAllAddresses() async {
    try {
      print('📖 Getting addresses from SharedPreferences...');
      final prefs = await SharedPreferences.getInstance();
      print('✓ SharedPreferences initialized');
      
      final List<String>? addressesJson = prefs.getStringList(_addressKey);
      print('Retrieved addresses: $addressesJson');

      if (addressesJson == null || addressesJson.isEmpty) {
        print('No addresses found');
        return [];
      }

      final addresses = addressesJson
          .map((address) => AddressModel.fromJsonString(address))
          .toList();
      print('✓ Converted ${addresses.length} addresses from JSON');
      return addresses;
    } catch (e) {
      print('❌ Error getting addresses: $e');
      print('Stack trace: ${StackTrace.current}');
      return [];
    }
  }

  // Add new address
  static Future<bool> addAddress(AddressModel address) async {
    try {
      print('📝 Adding new address...');
      print('Address to add: $address');
      
      final prefs = await SharedPreferences.getInstance();
      print('✓ SharedPreferences initialized');
      
      // Get existing addresses
      final List<String>? existingList = prefs.getStringList(_addressKey);
      List<String> existingAddresses = existingList ?? [];
      print('Existing addresses count: ${existingAddresses.length}');
      
      // Convert to JSON string
      final addressJson = address.toJsonString();
      print('Address JSON: $addressJson');
      
      if (addressJson.isEmpty) {
        print('❌ Address JSON is empty!');
        return false;
      }
      
      // Add new address
      existingAddresses.add(addressJson);
      print('✓ Address added to list. Total: ${existingAddresses.length}');
      
      // Save back to preferences
      print('💾 Saving ${existingAddresses.length} addresses to SharedPreferences...');
      final result = await prefs.setStringList(_addressKey, existingAddresses);
      
      print('Save result: $result');
      
      if (result) {
        print('✓ Address saved successfully!');
        
        // Verify by reading back
        final verifyList = prefs.getStringList(_addressKey);
        print('Verification - Addresses in storage: ${verifyList?.length}');
      } else {
        print('❌ setStringList returned false!');
      }
      
      return result;
    } catch (e) {
      print('❌ Exception in addAddress: $e');
      print('Error type: ${e.runtimeType}');
      print('Stack trace: ${StackTrace.current}');
      return false;
    }
  }

  // Delete address
  static Future<bool> deleteAddress(String addressId) async {
    try {
      print('🗑️ Deleting address with ID: $addressId');
      
      final prefs = await SharedPreferences.getInstance();
      List<String>? existingList = prefs.getStringList(_addressKey);
      
      if (existingList == null) {
        print('No addresses to delete');
        return false;
      }
      
      List<String> existingAddresses = existingList;
      final beforeCount = existingAddresses.length;

      existingAddresses.removeWhere((address) {
        final model = AddressModel.fromJsonString(address);
        return model.id == addressId;
      });
      
      final afterCount = existingAddresses.length;
      print('Removed ${beforeCount - afterCount} address(es)');

      final result = await prefs.setStringList(_addressKey, existingAddresses);
      print('✓ Delete successful: $result');
      return result;
    } catch (e) {
      print('❌ Error deleting address: $e');
      return false;
    }
  }

  // Update address
  static Future<bool> updateAddress(AddressModel address) async {
    try {
      print('✏️ Updating address with ID: ${address.id}');
      
      final prefs = await SharedPreferences.getInstance();
      List<String>? existingList = prefs.getStringList(_addressKey);
      
      if (existingList == null) {
        print('No addresses to update');
        return false;
      }
      
      List<String> existingAddresses = existingList;

      final index = existingAddresses.indexWhere((addr) {
        final model = AddressModel.fromJsonString(addr);
        return model.id == address.id;
      });

      if (index != -1) {
        existingAddresses[index] = address.toJsonString();
        final result = await prefs.setStringList(_addressKey, existingAddresses);
        print('✓ Update successful: $result');
        return result;
      } else {
        print('❌ Address not found for update');
        return false;
      }
    } catch (e) {
      print('❌ Error updating address: $e');
      return false;
    }
  }
}
