import 'dart:convert';

class AddressModel {
  final String id;
  final String name;
  final String address;

  AddressModel({
    required this.id,
    required this.name,
    required this.address,
  });

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }

  // Create model from JSON
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
    );
  }

  // Convert model to string for storage
  String toJsonString() {
    try {
      return jsonEncode(toJson());
    } catch (e) {
      print('Error encoding address to JSON: $e');
      return '';
    }
  }

  // Create model from string
  factory AddressModel.fromJsonString(String jsonString) {
    try {
      return AddressModel.fromJson(jsonDecode(jsonString));
    } catch (e) {
      print('Error decoding address from JSON: $e');
      return AddressModel(
        id: '',
        name: '',
        address: '',
      );
    }
  }

  @override
  String toString() {
    return 'AddressModel(id: $id, name: $name, address: $address)';
  }
}
