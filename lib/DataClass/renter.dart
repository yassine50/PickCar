import 'package:json_annotation/json_annotation.dart';
import 'package:pickcar/DataClass/bankDetails.dart';
import 'package:pickcar/DataClass/car.dart';
import 'package:pickcar/DataClass/user.dart';

@JsonSerializable(explicitToJson: true)
class Renter {
  String? renterIdentifier;
  String? type;
  User? user;
  BankCardDetail? bankCardDetail;
  List<Car>? cars;

  Renter({
    this.renterIdentifier,
    this.type,
    this.user,
    this.bankCardDetail,
    this.cars,
  });

  factory Renter.fromJson(Map<String, dynamic> json) {
    return Renter(
      renterIdentifier: json['renterIdentifier'] as String?,
      type: json['type'] as String?,
      user: json['user'] == null ? null : User.fromJson(json['user'] as Map<String, dynamic>),
      bankCardDetail: json['bankCardDetail'] == null ? null : BankCardDetail.fromJson(json['bankCardDetail'] as Map<String, dynamic>),
      cars: (json['cars'] as List<dynamic>?)?.map((e) => Car.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'renterIdentifier': renterIdentifier,
      'type': type,
      'user': user?.toJson(),
      'bankCardDetail': bankCardDetail?.toJson(),
      'cars': cars?.map((car) => car.toJson()).toList(),
    };
  }
}
