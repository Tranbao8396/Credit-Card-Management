import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_management/src/types/bank_card.dart';

class Bank {
  final String? id;
  final String? bankName;
  final String? bankUrl;
  final List<BankCard?>? bankCards;

  Bank({
    this.id,
    this.bankName,
    this.bankUrl,
    this.bankCards
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    List list = json['bank_cards'] as List;
    List<BankCard?> bankCardList = list.map((e) => BankCard.fromJson(e)).toList();

    return Bank(
      id: json['id']??'',
      bankName: json['bank_name'],
      bankUrl: json['bank_url'],
      bankCards: bankCardList
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bank_name': bankName,
      'bank_url': bankUrl,
      'bank_cards': bankCards?.map((e) => e?.toMap()).toList(),
      'updatedAt': FieldValue.serverTimestamp(), // Thêm dấu thời gian
    };
  }
}