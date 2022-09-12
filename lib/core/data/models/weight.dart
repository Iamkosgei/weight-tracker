import 'dart:convert';

class Weight {
  Weight(
      {this.createdDate,
      this.updatedDate,
      this.userId,
      this.weight,
      this.documentId});

  final int? createdDate;
  final int? updatedDate;
  final String? userId;
  final int? weight;
  final String? documentId;

  factory Weight.fromRawJson(String str, String? docId) =>
      Weight.fromJson(json.decode(str), docId);

  Weight copyWith(
          {int? createdDate,
          int? updatedDate,
          String? userId,
          int? weight,
          String? documentId}) =>
      Weight(
          createdDate: createdDate ?? this.createdDate,
          updatedDate: updatedDate ?? this.updatedDate,
          userId: userId ?? this.userId,
          weight: weight ?? this.weight,
          documentId: documentId ?? this.documentId);

  String toRawJson() => json.encode(toJson());

  factory Weight.fromJson(Map<String, dynamic> json, String? documentId) =>
      Weight(
          createdDate: json["createdDate"],
          updatedDate: json["updatedDate"],
          userId: json["userId"],
          weight: json["weight"],
          documentId: documentId);

  Map<String, dynamic> toJson() => {
        "createdDate": createdDate,
        "updatedDate": updatedDate,
        "userId": userId,
        "weight": weight,
      };
}
