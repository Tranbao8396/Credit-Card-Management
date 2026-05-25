import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_management/models/card_model.dart';
import 'package:credit_management/services/authentication_service.dart';
import 'package:credit_management/subpages/card_detail/card_detail_state.dart';
import 'package:credit_management/types/category.dart';
import 'package:credit_management/types/card_transaction.dart';
import 'package:flutter/material.dart';

class CardDetailLogic extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final CardDetailState state = CardDetailState();
  final userId = AuthenticationService.instance.userInfo?.uid;

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true; // Đánh dấu đã dispose
    super.dispose();
  }

  final CardModel card;

  CardDetailLogic({required this.card}) {
    getCashBackList();
    getTransactionsList();
    getTransactionCost();
    getLimitSpending();
  }

  void setStartDate(DateTime startDate) {
    state.startDate = startDate;
    notifyListeners();
  }

  void setEndDate(DateTime endDate) {
    state.endDate = endDate;
    notifyListeners();
  }

  void setTransactionName(String transaction) {
    state.transactionName = transaction;
    notifyListeners();
  }

  void setPrice(String price) {
    state.price = double.tryParse(price);
    notifyListeners();
  }

  void setCategory(Category? category) {
    state.category = category;
    notifyListeners();
  }

  void setTransactionDate(DateTime datetime) {
    state.transactionDate = datetime;
    notifyListeners();
  }

  void setLimit(String limit) {
    state.limitSpending = double.tryParse(limit);
    notifyListeners();
  }

  Future<void> getCashBackList() async {
    try {
      final cardId = card.cardInfoId;
      final bankId = card.bankId;
      final queryBanks = await _db.collection('banks').doc(bankId).get();
      final bankData = queryBanks.data();
      final userCard = bankData!['bank_cards']
          .where((card) => card['card_id'] == cardId)
          .single;
      state.cashBackCat = userCard['card_categories']
          .map<Category?>(
            (e) => Category(
              categoryName: e['category_name'],
              cashBack: e['cash_back'],
            ),
          )
          .toList();
      if (_isDisposed) return;
      notifyListeners();
    } catch (e) {
      throw ("Error: $e");
    }
  }

  Future<void> addTransaction(BuildContext context) async {
    if (state.isValid) return;
    try {
      await _db.collection('users').doc(userId).collection('transactions').add({
        'card_id': card.cardInfoId,
        'transaction_name': state.transactionName,
        'price': state.price,
        'category_id': state.category!.id,
        'createdOn': state.transactionDate ?? DateTime.now(),
      });
      clear();
      notifyListeners();
    } catch (e) {
      throw ('Error: $e');
    }

    if (!context.mounted) return;
    Navigator.of(context).pop(true);
  }

  Future<void> getTransactionsList() async {
    try {
      final query = await _db
          .collection('users')
          .doc(userId)
          .collection('transactions')
          .where('card_id', isEqualTo: card.cardInfoId)
          .where('createdOn', isGreaterThanOrEqualTo: state.startDate)
          .where('createdOn', isLessThanOrEqualTo: state.endDate)
          .get();

      state.transactions = query.docs.map<CardTransaction?>((e) {
        final data = e.data();

        final cat = state.cashBackCat
            ?.where((e) => e?.id == data['category_id'])
            .firstOrNull;

        return CardTransaction(
          transactionName: data['transaction_name'],
          categoryName: cat?.categoryName,
          price: data['price'],
          cashBackRatio: cat?.cashBack,
          createdOn: data['createdOn'].toDate(),
        );
      }).toList();
      if (_isDisposed) return;
      notifyListeners();
    } catch (e) {
      throw ("Error: $e");
    }
  }

  Future<void> getTransactionCost() async {
    try {
      final currentDate = DateTime.now();
      final startMonth = DateTime(currentDate.year, currentDate.month, 1);
      final endMonth = DateTime(currentDate.year, currentDate.month + 1, 0);

      final query = await _db
          .collection('users')
          .doc(userId)
          .collection('transactions')
          .where('card_id', isEqualTo: card.cardInfoId)
          .where('createdOn', isGreaterThanOrEqualTo: startMonth)
          .where('createdOn', isLessThanOrEqualTo: endMonth)
          .get();

      state.totalSpending = query.docs.fold(
        0.0,
        (cost, doc) => cost! + (doc.data()['price'] as num).toDouble(),
      );
      if (_isDisposed) return;
      notifyListeners();
    } catch (e) {
      throw ("Error: $e");
    }
  }

  Future<void> setLimitSpending(BuildContext context) async {
    try {
      if (state.limitSpending != null && state.limitSpending! > 0) {
        await _db
            .collection('users')
            .doc(userId)
            .collection('cards')
            .doc(card.id)
            .update({'limit_spending': state.limitSpending});
      }
      state.limitSpending = null;
      notifyListeners();
    } catch (e) {
      throw ("Error: $e");
    }
    if (!context.mounted) return;
    Navigator.of(context).pop(true);
  }

  Future<void> getLimitSpending() async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('cards')
          .doc(card.id)
          .get()
          .then((doc) {
            if (doc.exists) {
              final data = doc.data();
              state.limitVal = data?['limit_spending']?.toDouble() ?? 0.0;
            }
          });
      notifyListeners();
    } catch (e) {
      throw ("Error: $e");
    }
  }

  void clear() {
    state.category = null;
    state.price = null;
    state.transactionDate = null;
    state.transactionName = null;
  }
}
