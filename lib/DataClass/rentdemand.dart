import 'package:json_annotation/json_annotation.dart';
import 'car.dart';
import 'customer.dart';

@JsonSerializable(explicitToJson: true)
class RentDemand {
  String? rentDemandIdentifier;
  Car? car;
  Customer? customer;
  DateTime? dateBegin;
  DateTime? dateEnd;
  String? status;
  double? price;

  RentDemand({
    this.rentDemandIdentifier,
    this.car,
    this.customer,
    this.dateBegin,
    this.dateEnd,
    this.status,
    this.price,
  });

  factory RentDemand.fromJson(Map<String, dynamic> json) {
    return RentDemand(
      rentDemandIdentifier: json['rentDemandIdentifier'] as String?,
     // car: json['car'] != null ? Car.fromJson(json['car'] as Map<String, dynamic>) : null,
      //customer: json['customer'] != null ? Customer.fromJson(json['customer'] as Map<String, dynamic>) : null,
      dateBegin: json['dateBegin'] != null ? DateTime.parse(json['dateBegin'] as String) : null,
      dateEnd: json['dateEnd'] != null ? DateTime.parse(json['dateEnd'] as String) : null,
      status: json['statusFrName'] as String?,
      price: json['rentPrice'] != null ? (json['rentPrice'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rentDemandIdentifier': rentDemandIdentifier,
      'car': car?.toJson(),
      'customer': customer?.toJson(),
      'dateBegin': dateBegin?.toIso8601String(),
      'dateEnd': dateEnd?.toIso8601String(),
      'statusFrName': status,
      'price': price,
    };
  }
}
