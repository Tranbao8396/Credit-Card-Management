import 'package:credit_management/src/models/card_model.dart';
import 'package:credit_management/src/types/bank.dart';
import 'package:credit_management/src/types/bank_card.dart';

class CardPageState {
  BankCard? cardInfo;
  String? cardNumber;
  DateTime? cardExpiryDate;
  DateTime? statementDate;
  String? cardType;
  Bank? cardBank;
  bool isLoading = false;
  bool isError = false;
  List<CardModel> cards = [];
  List<Bank> banks = [];
  List<BankCard>? bankCards = [];
}