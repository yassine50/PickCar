
import 'package:json_annotation/json_annotation.dart';
import 'package:pickcar/DataClass/payment.dart';
import 'package:pickcar/DataClass/rentdemand.dart';

@JsonSerializable(explicitToJson: true)
class Rent {
  String? id;
  List<String>? carPhotosBefore;
  List<String>? carPhotosAfter;
  String? comment;
  String? status;
  RentDemand? rentDemand;
//  Payment? payment;

  Rent({
    this.id,
    this.carPhotosBefore,
    this.carPhotosAfter,
    this.comment,
    this.status,
    this.rentDemand,
   // this.payment,
  });

  factory Rent.fromJson(Map<String, dynamic> json) {
    return Rent(
      id: json['rentIdentifier'] as String?,
     // carPhotosBefore: (json['carPhotosBefore'] as List?)?.map((e) => e as String).toList(),
      //carPhotosAfter: (json['carPhotosAfter'] as List?)?.map((e) => e as String).toList(),
     // comment: json['comment'] as String?,
           comment:"hhh",

      status: json['statusTitle'] as String?,
      rentDemand: json['rentDemand'] == null ? null : RentDemand.fromJson(json['rentDemand'] as Map<String, dynamic>),
       // payment: json['payment'] == null ? null : Payment.fromJson(json['payment'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'carPhotosBefore': carPhotosBefore,
      'carPhotosAfter': carPhotosAfter,
      'comment': comment,
      'status': status,
      'rentDemand': rentDemand?.toJson(),
     // 'payment': payment?.toJson(),
    };
  }
}
