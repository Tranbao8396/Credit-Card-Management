import 'package:credit_management/src/models/card_model.dart';
import 'package:credit_management/src/types/category.dart';
import 'package:credit_management/src/types/card_transaction.dart';

class CardDetailState {
  DateTime? startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime? endDate = DateTime.now().add(Duration(days: 7));
  String? transactionName;
  double? price;
  double? totalSpending;
  double? totalCashBack;
  double? limitSpending;
  double? limitVal;
  Category? category;
  List<Category?>? cashBackCat;
  DateTime? transactionDate;
  bool get isValid => transactionName == null || price == null || category == null;
  List<CardTransaction?>? transactions;
  List<CardModel>? userCards;
  CardModel? pickedCard;
}