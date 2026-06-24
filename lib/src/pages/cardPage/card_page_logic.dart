import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_management/src/models/card_model.dart';
import 'package:credit_management/src/pages/cardPage/card_page_state.dart';
import 'package:credit_management/src/services/authentication_service.dart';
import 'package:credit_management/src/types/bank.dart';
import 'package:credit_management/src/types/bank_card.dart';
import 'package:flutter/material.dart';

class HomePageLogic extends ChangeNotifier {
  final CardPageState state = CardPageState();
  final userId = AuthenticationService.instance.userInfo?.uid;
  final _db = FirebaseFirestore.instance;

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true; // Đánh dấu đã dispose
    super.dispose();
  }

  HomePageLogic() {
    getCards();
    getBanksList();
  }

  void setCardInfo(BankCard card) {
    state.cardInfo = card;
    state.cardType = card.cardService;
    notifyListeners();
  }

  void setCardNumber(String number) {
    state.cardNumber = number;
    notifyListeners();
  }

  void setCardExpiryDate(DateTime expiryDate) {
    state.cardExpiryDate = expiryDate;
    notifyListeners();
  }

  void setStatementDate(DateTime statementDate) {
    state.statementDate = statementDate;
    notifyListeners();
  }

  void setCardType(String type) {
    final cardInfo = state.cardInfo;
    if (cardInfo == null) return;
    state.cardType = cardInfo.cardService;
    notifyListeners();
  }

  void setBank(Bank? bank) async {
    state.cardBank = bank;

    // Clear giá trị của thẻ
    state.cardInfo = null;
    state.cardType = null;

    await getCardsList(bankId: bank?.id ?? '');

    notifyListeners();
  }

  Future<void> getCards() async {
    try {
      final querySnapshot = await _db
          .collection('users')
          .doc(userId)
          .collection('cards')
          .orderBy('createdAt', descending: true)
          .get();

      final userCardsList = await Future.wait(querySnapshot.docs.map<Future<CardModel>>((e) async {
        final data = e.data();

        final cardInfo = await getCardInfo(bankId: data['bank_info'], cardInfoId: data['card_info']);

        return CardModel(
          id: e.id,
          bankId: data['bank_info'],
          bankName: cardInfo?.bankName??'',
          cardInfoId: data['card_info'],
          cardName: cardInfo?.bankCards?.first?.cardName??'',
          number: data['card_number'],
          cardService: data['card_type'],
          expiryDate: (data['card_expiry_date'] as Timestamp).toDate(),
          statementDate: (data['card_statement_date'] as Timestamp?)?.toDate(),
        );
      }));
      state.cards = userCardsList;
      if (_isDisposed) return;
      notifyListeners();
    } catch (e) {
      if (_isDisposed) return;
      throw Exception('Failed to fetch cards: $e');
    }
  }

  Future<void> addCard(BuildContext context) async {
    if (state.cardInfo == null ||
        state.cardNumber == null ||
        state.cardExpiryDate == null ||
        state.cardType == null ||
        state.cardBank == null) {
      state.isError = true;
      notifyListeners();
      return;
    }

    // Kiểm tra trùng số thẻ
    final existingCard = await _db
        .collection('users')
        .doc(userId)
        .collection('cards')
        .where('card_number', isEqualTo: state.cardNumber)
        .get();

    if (existingCard.docs.isNotEmpty) {
      state.isError = true;
      notifyListeners();
      return;
    }

    state.isLoading = true;
    notifyListeners();

    try {
      // Lưu thông tin thẻ vào Firestore
      await _db.collection('users').doc(userId).collection('cards').add({
        'bank_info': state.cardBank?.id,
        'card_info': state.cardInfo?.cardId,
        'card_number': state.cardNumber,
        'card_expiry_date': state.cardExpiryDate,
        'card_statement_date': state.statementDate,
        'card_type': state.cardType,
        'createdAt': DateTime.now(),
      });
      state.isLoading = false;
      state.isError = false;

      // Sau khi thêm thẻ, có thể xóa dữ liệu nhập để chuẩn bị cho lần nhập tiếp theo
      clearState();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add card: $e');
    }
    if (!context.mounted) return;
    Navigator.of(context).pop(true);
  }

  Future<void> deleteCard(BuildContext context, String cardId) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('cards')
          .doc(cardId)
          .delete();
      await getCards(); // Cập nhật lại danh sách thẻ sau khi xóa
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete card: $e');
    }

    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> getBanksList() async {
    try {
      final res = await _db.collection('banks').get();
      state.banks = res.docs.map<Bank>((e) {
        final data = e.data();
        return Bank(id: e.id, bankName: data['bank_name']);
      }).toList();
      notifyListeners();
    } catch (e) {
      throw ("Error $e");
    }
  }

  Future<void> getCardsList({required String bankId}) async {
    try {
      final res = await _db.collection('banks').doc(bankId).get();
      final data = res.data();
      final cardList = data?['bank_cards'];
      state.bankCards = cardList.map<BankCard>((e) {
        return BankCard(
          cardId: e['card_id'],
          cardName: e['card_name'],
          cardService: e['card_service']
        );
      }).toList();
      if (_isDisposed) return;
      notifyListeners();
    } catch (e) {
      if (_isDisposed) return;
      throw ("error $e");
    }
  }

  Future<Bank?> getCardInfo({required String bankId, required String cardInfoId}) async {
    try {
      final res = await _db.collection('banks').doc(bankId).get();
      final data = res.data();
      final cardsList = data?['bank_cards'];
      final cardData = cardsList.where((bankCard) => bankCard['card_id'] == cardInfoId).single;
      final cardDataCon = BankCard(
        cardName: cardData['card_name'],
        cardService: cardData['card_service']
      );
      return Bank(
        bankName: data?['bank_name'],
        bankCards: <BankCard>[cardDataCon]
      );
    } catch (e) {
      throw('Error: $e');
    }
  }

  void clearState() {
    state.cardBank = null;
    state.cardInfo = null;
    state.cardNumber = null;
    state.cardExpiryDate = null;
    state.cardType = null;
  }
}
