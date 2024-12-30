import 'package:json_annotation/json_annotation.dart';
import 'rent.dart'; 

@JsonSerializable(explicitToJson: true)
class Payment {
  String id;
  double payment;
  @JsonKey(ignore: true)
  Rent rent;

  Payment({
    required this.id,
    required this.payment,
    required this.rent,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] as String,
      payment: (json['payment'] as num).toDouble(),
      rent: Rent.fromJson(json['rent'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    final json = {
      'id': id,
      'payment': payment,
      'rent': rent.toJson(),
    };
    return json;
  }
}
