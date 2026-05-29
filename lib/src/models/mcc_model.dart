class MccModel {
  final int? id;
  final String? name;
  final String? code;
  final List<String>? cats; 
  final List<dynamic>? methods;

  MccModel({this.id, this.name, this.code, this.cats, this.methods});

  factory MccModel.fromJson(Map<String, dynamic> json) {
    return MccModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      cats: (json['cats'] as List<dynamic>?)
          ?.map((cat) => cat as String)
          .toList(),
      methods: json['methods'] as List<dynamic>?,
    );
  }
}