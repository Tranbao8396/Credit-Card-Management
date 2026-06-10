import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_management/src/models/card_model.dart';
import 'package:credit_management/src/services/authentication_service.dart';
import 'package:credit_management/src/subpages/card_detail/card_detail_state.dart';
import 'package:credit_management/src/types/bank.dart';
import 'package:credit_management/src/types/bank_card.dart';
import 'package:credit_management/src/types/category.dart';
import 'package:credit_management/src/types/card_transaction.dart';
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

  final CardModel? card;

  CardDetailLogic({this.card}) {
    if (card != null) {
      getCashBackList();
      getTransactionsList();
      getTransactionTotal();
      getCashBackTotal();
      getLimitSpending();
    } else {
      getUserCardsList();
    }
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

  void setCard(CardModel? card) async {
    state.pickedCard = card;
    await getCashBackList();
    notifyListeners();
  }

  Future<void> getCashBackList() async {
    try {
      final cardId = card?.cardInfoId ?? state.pickedCard?.cardInfoId;
      final bankId = card?.bankId ?? state.pickedCard?.bankId;
      final queryBanks = await _db.collection('banks').doc(bankId).get();
      final bankData = queryBanks.data();
      if (bankData == null) return;
      final userCard = bankData['bank_cards']
          .where((card) => card['card_id'] == cardId)
          .single;
      state.cashBackCat = userCard['card_categories']
          .map<Category?>(
            (e) => Category(
              categoryName: e['category_name'],
              cashBack: double.tryParse(e['cash_back']),
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
    final pickedCard = state.pickedCard;
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('cards')
          .doc(card?.id ?? pickedCard?.id)
          .collection('transactions')
          .add({
            'transaction_name': state.transactionName,
            'price': state.price,
            'category_name': state.category!.categoryName,
            'cash_back': state.category!.cashBack,
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
          .collection('cards')
          .doc(card?.id)
          .collection('transactions')
          .where('createdOn', isGreaterThanOrEqualTo: state.startDate)
          .where('createdOn', isLessThanOrEqualTo: state.endDate)
          .get();

      state.transactions = query.docs.map<CardTransaction?>((e) {
        final data = e.data();

        return CardTransaction(
          id: e.id,
          transactionName: data['transaction_name'],
          categoryName: data['category_name'],
          price: data['price'],
          cashBackRatio: data['cash_back'],
          createdOn: data['createdOn'].toDate(),
        );
      }).toList();
      if (_isDisposed) return;
      notifyListeners();
    } catch (e) {
      throw ("Error: $e");
    }
  }

  Future<void> getTransactionTotal() async {
    try {
      final query = await _db
          .collection('users')
          .doc(userId)
          .collection('cards')
          .doc(card?.id)
          .collection('transactions')
          .where('createdOn', isGreaterThanOrEqualTo: state.startDate)
          .where('createdOn', isLessThanOrEqualTo: state.endDate)
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

  Future<void> getCashBackTotal() async {
    try {
      final query = await _db
          .collection('users')
          .doc(userId)
          .collection('cards')
          .doc(card?.id)
          .collection('transactions')
          .where('createdOn', isGreaterThanOrEqualTo: state.startDate)
          .where('createdOn', isLessThanOrEqualTo: state.endDate)
          .get();

      state.totalCashBack = query.docs.fold(
        0.0,
        (cost, doc) => cost! + (((doc.data()['cash_back'] / 100) * doc.data()['price']) as num).toDouble(),
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
            .doc(card?.id)
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
          .doc(card?.id)
          .get()
          .then((doc) {
            if (doc.exists) {
              final data = doc.data();
              state.limitVal = data?['limit_spending']?.toDouble() ?? 0.0;
            }
          });
      if (_isDisposed) return;
      notifyListeners();
    } catch (e) {
      throw ("Error: $e");
    }
  }

  Future<void> delateTransaction(
    BuildContext context,
    String transactionid,
  ) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('cards')
          .doc(card?.id)
          .collection('transactions')
          .doc(transactionid)
          .delete();

      await getTransactionsList();
      await getTransactionTotal();
      await getCashBackTotal();
      notifyListeners();
    } catch (e) {
      throw {"Error: $e"};
    }
    if (!context.mounted) return;
    Navigator.of(context).pop(true);
  }

  Future<Bank?> getCardInfo({
    required String bankId,
    required String cardInfoId,
  }) async {
    try {
      final res = await _db.collection('banks').doc(bankId).get();
      final data = res.data();
      final cardsList = data?['bank_cards'];
      final cardData = cardsList
          .where((bankCard) => bankCard['card_id'] == cardInfoId)
          .single;
      final cardDataCon = BankCard(
        cardName: cardData['card_name'],
        cardService: cardData['card_service'],
      );
      return Bank(
        bankName: data?['bank_name'],
        bankCards: <BankCard>[cardDataCon],
      );
    } catch (e) {
      throw ('Error: $e');
    }
  }

  Future<void> getUserCardsList() async {
    try {
      final query = await _db
          .collection('users')
          .doc(userId)
          .collection('cards')
          .get();

      final userCardsList = await Future.wait(
        query.docs.map<Future<CardModel>>((e) async {
          final data = e.data();

          final cardInfo = await getCardInfo(
            bankId: data['bank_info'],
            cardInfoId: data['card_info'],
          );

          return CardModel(
            id: e.id,
            bankId: data['bank_info'],
            bankName: cardInfo?.bankName ?? '',
            cardInfoId: data['card_info'],
            cardName: cardInfo?.bankCards?.first?.cardName ?? '',
            number: data['card_number'],
            cardService: data['card_type'],
            expiryDate: (data['card_expiry_date'] as Timestamp).toDate(),
          );
        }),
      );
      state.userCards = userCardsList;

      if (_isDisposed) return;
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
