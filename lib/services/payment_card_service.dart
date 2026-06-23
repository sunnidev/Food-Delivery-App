import 'package:shared_preferences/shared_preferences.dart';
import '../models/payment_card_model.dart';

class PaymentCardService {
  static const String _cardsKey = 'payment_cards';

  // Get all payment cards
  static Future<List<PaymentCardModel>> getAllCards() async {
    try {
      print('📖 Getting payment cards from storage...');
      final prefs = await SharedPreferences.getInstance();
      
      final List<String>? cardsJson = prefs.getStringList(_cardsKey);
      
      if (cardsJson == null || cardsJson.isEmpty) {
        print('No payment cards found');
        return [];
      }

      final cards = cardsJson
          .map((card) => PaymentCardModel.fromJsonString(card))
          .toList();
      print('✓ Retrieved ${cards.length} payment cards');
      return cards;
    } catch (e) {
      print('❌ Error getting payment cards: $e');
      return [];
    }
  }

  // Add new payment card
  static Future<bool> addCard(PaymentCardModel card) async {
    try {
      print('💳 Adding new payment card...');
      print('Card: ${card.cardHolderName} - ${card.getMaskedCardNumber()}');
      
      final prefs = await SharedPreferences.getInstance();
      
      List<String> existingCards = prefs.getStringList(_cardsKey) ?? [];
      print('Existing cards: ${existingCards.length}');
      
      final cardJson = card.toJsonString();
      if (cardJson.isEmpty) {
        print('❌ Card JSON is empty!');
        return false;
      }
      
      existingCards.add(cardJson);
      final result = await prefs.setStringList(_cardsKey, existingCards);
      
      if (result) {
        print('✓ Payment card saved successfully!');
      } else {
        print('❌ Failed to save payment card');
      }
      
      return result;
    } catch (e) {
      print('❌ Exception in addCard: $e');
      return false;
    }
  }

  // Delete payment card
  static Future<bool> deleteCard(String cardId) async {
    try {
      print('🗑️ Deleting payment card with ID: $cardId');
      
      final prefs = await SharedPreferences.getInstance();
      List<String>? existingList = prefs.getStringList(_cardsKey);
      
      if (existingList == null) {
        print('No payment cards to delete');
        return false;
      }
      
      List<String> existingCards = existingList;
      final beforeCount = existingCards.length;

      existingCards.removeWhere((card) {
        final model = PaymentCardModel.fromJsonString(card);
        return model.id == cardId;
      });
      
      final afterCount = existingCards.length;
      print('Removed ${beforeCount - afterCount} card(s)');

      final result = await prefs.setStringList(_cardsKey, existingCards);
      print('✓ Delete successful: $result');
      return result;
    } catch (e) {
      print('❌ Error deleting payment card: $e');
      return false;
    }
  }

  // Update payment card
  static Future<bool> updateCard(PaymentCardModel card) async {
    try {
      print('✏️ Updating payment card with ID: ${card.id}');
      
      final prefs = await SharedPreferences.getInstance();
      List<String>? existingList = prefs.getStringList(_cardsKey);
      
      if (existingList == null) {
        print('No payment cards to update');
        return false;
      }
      
      List<String> existingCards = existingList;

      final index = existingCards.indexWhere((cardStr) {
        final model = PaymentCardModel.fromJsonString(cardStr);
        return model.id == card.id;
      });

      if (index != -1) {
        existingCards[index] = card.toJsonString();
        final result = await prefs.setStringList(_cardsKey, existingCards);
        print('✓ Update successful: $result');
        return result;
      } else {
        print('❌ Payment card not found for update');
        return false;
      }
    } catch (e) {
      print('❌ Error updating payment card: $e');
      return false;
    }
  }

  // Set default card
  static Future<bool> setDefaultCard(String cardId) async {
    try {
      print('⭐ Setting card as default: $cardId');
      
      final prefs = await SharedPreferences.getInstance();
      List<String>? existingList = prefs.getStringList(_cardsKey);
      
      if (existingList == null) return false;
      
      List<String> existingCards = existingList;
      
      // Update all cards
      existingCards = existingCards.map((cardStr) {
        final model = PaymentCardModel.fromJsonString(cardStr);
        final updatedCard = PaymentCardModel(
          id: model.id,
          cardHolderName: model.cardHolderName,
          cardNumber: model.cardNumber,
          expiryDate: model.expiryDate,
          cvv: model.cvv,
          isDefault: model.id == cardId,
        );
        return updatedCard.toJsonString();
      }).toList();
      
      final result = await prefs.setStringList(_cardsKey, existingCards);
      print('✓ Default card set: $result');
      return result;
    } catch (e) {
      print('❌ Error setting default card: $e');
      return false;
    }
  }
}
