import 'package:json_annotation/json_annotation.dart';
import 'package:pickcar/DataClass/user.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  int? id;
  String? city;
  String? street;
  String? country;
  String? zipCode;
  double? lat; 
  double? lon; 

  Address({
    this.id,
    this.city,
    this.street,
    this.country,
    this.zipCode,
    this.lat,
    this.lon,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as int?,
      city: json['city'] as String?,
      street: json['street'] as String?,
      country: json['country'] as String?,
      zipCode: json['zipCode'] as String?,
      lat: json['Latitude'] as double?,
      lon: json['longitude'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': city,
      'street': street,
      'country': country,
      'zipCode': zipCode,
      'Latitude': lat,
      'longitude': lon,
    };
  }
}
