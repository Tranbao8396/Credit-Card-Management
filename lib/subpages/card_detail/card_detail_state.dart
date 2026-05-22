import 'package:credit_management/types/category.dart';
import 'package:credit_management/types/card_transaction.dart';

class CardDetailState {
  DateTime? startDate;
  DateTime? endDate;
  String? transactionName;
  double? price;
  Category? category;
  List<Category?>? cashBackCat;
  DateTime? transactionDate;
  bool get isValid => transactionName == null || price == null || category == null;
  List<CardTransaction?>? transactions;
}