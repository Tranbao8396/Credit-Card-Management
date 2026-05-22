class CardModel {
  String? id;
  String? bankId;
  String? bankName;
  String? cardInfoId;
  String? cardName;
  String? number;
  String? cardService;
  DateTime? expiryDate;

  CardModel({
    this.id,
    this.bankId,
    this.bankName,
    this.cardInfoId,
    this.cardName,
    this.number,
    this.cardService,
    this.expiryDate,
  });
}