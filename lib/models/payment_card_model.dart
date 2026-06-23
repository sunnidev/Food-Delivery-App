import 'dart:convert';

class PaymentCardModel {
  final String id;
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final bool isDefault;

  PaymentCardModel({
    required this.id,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    this.isDefault = false,
  });

  // Get masked card number (shows last 4 digits)
  String getMaskedCardNumber() {
    if (cardNumber.length < 4) return cardNumber;
    return '*** *** *** ${cardNumber.substring(cardNumber.length - 4)}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'isDefault': isDefault,
    };
  }

  factory PaymentCardModel.fromJson(Map<String, dynamic> json) {
    return PaymentCardModel(
      id: json['id'] ?? '',
      cardHolderName: json['cardHolderName'] ?? '',
      cardNumber: json['cardNumber'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
      cvv: json['cvv'] ?? '',
      isDefault: json['isDefault'] ?? false,
    );
  }

  String toJsonString() {
    try {
      return jsonEncode(toJson());
    } catch (e) {
      print('Error encoding card to JSON: $e');
      return '';
    }
  }

  factory PaymentCardModel.fromJsonString(String jsonString) {
    try {
      return PaymentCardModel.fromJson(jsonDecode(jsonString));
    } catch (e) {
      print('Error decoding card from JSON: $e');
      return PaymentCardModel(
        id: '',
        cardHolderName: '',
        cardNumber: '',
        expiryDate: '',
        cvv: '',
      );
    }
  }

  @override
  String toString() {
    return 'PaymentCardModel(id: $id, name: $cardHolderName, masked: ${getMaskedCardNumber()})';
  }
}
