class Category {
  final String? id;
  final String? categoryName;
  final double? cashBack;

  Category({
    this.id,
    this.categoryName,
    this.cashBack
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id']??'',
      categoryName: json['category_name'],
      cashBack: double.tryParse(json['cash_back']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "category_name": categoryName,
      "cash_back": cashBack,
    };
  }
}