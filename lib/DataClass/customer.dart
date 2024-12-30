import 'package:json_annotation/json_annotation.dart';
import 'package:pickcar/DataClass/bankAccount.dart';
import 'package:pickcar/DataClass/rentdemand.dart';
import 'user.dart';
import 'renter.dart';

@JsonSerializable(explicitToJson: true)
class Customer {
  String? customerIdentifier;
  User? user;
  List<RentDemand>? rentDemands;
  BankAccount? bankAccount;

  Customer({
    this.customerIdentifier,
    this.user,
    this.rentDemands,
    this.bankAccount,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerIdentifier: json['customerIdentifier'] as String?,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      rentDemands: (json['rentDemands'] as List<dynamic>?)
          ?.map((e) => RentDemand.fromJson(e as Map<String, dynamic>))
          .toList(),
      bankAccount: json['bankAccount'] != null
          ? BankAccount.fromJson(json['bankAccount'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerIdentifier': customerIdentifier,
      'user': user?.toJson(),
      'rentDemands': rentDemands?.map((demand) => demand.toJson()).toList(),
      'bankAccount': bankAccount?.toJson(),
    };
  }
}
