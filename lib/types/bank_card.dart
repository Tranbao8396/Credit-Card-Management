import 'package:credit_management/types/category.dart';

class BankCard {
  final String? cardId;
  final String? cardName;
  final String? cardTypes;
  final String? cardService;
  final double? cardYearlyFee;
  final List<Category?>? cardCategories;

  BankCard({
    this.cardId,
    this.cardName,
    this.cardTypes,
    this.cardService,
    this.cardYearlyFee,
    this.cardCategories,
  });

  factory BankCard.fromJson(Map<String, dynamic> json) {
    var list = json['card_categories'] as List;
    List<Category?> categories = list.map((e) => Category.fromJson(e)).toList();

    return BankCard(
      cardId: json['card_id']??'',
      cardName: json['card_name'],
      cardTypes: json['card_types'],
      cardService: json['card_service'],
      cardYearlyFee: double.tryParse(json['card_yearly_fee']),
      cardCategories: categories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "card_id": cardId,
      "card_name": cardName,
      "card_types": cardTypes,
      "card_service": cardService,
      "card_yearly_fee": cardYearlyFee,
      "card_categories": cardCategories?.map((e) =>e?.toMap()).toList(),
    };
  }
}