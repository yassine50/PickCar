import 'package:json_annotation/json_annotation.dart';
import 'package:pickcar/DataClass/renter.dart';

@JsonSerializable()
class BankCardDetail {
  String cardNumber;
  DateTime expirationDate;
  
  // Make the renter field transient during serialization
  @JsonKey(ignore: true)
  Renter renter;

  BankCardDetail({
    required this.cardNumber,
    required this.expirationDate,
    required this.renter,
  });

  factory BankCardDetail.fromJson(Map<String, dynamic> json) {
    return BankCardDetail(
      cardNumber: json['cardNumber'] as String,
      expirationDate: DateTime.parse(json['expirationDate'] as String),
      // Deserialize the renter field manually
      // Assuming renter data is nested under a key called 'renter'
      renter: Renter.fromJson(json['renter'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    // Serialize the renter field manually
    final json = {
      'cardNumber': cardNumber,
      'expirationDate': expirationDate.toIso8601String(),
      // Do not include the renter field in the JSON
    };
    return json;
  }
}
