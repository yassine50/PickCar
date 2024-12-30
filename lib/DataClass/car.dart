import 'package:json_annotation/json_annotation.dart';
import 'package:pickcar/DataClass/address.dart';
import 'package:pickcar/DataClass/rentdemand.dart';
import 'package:pickcar/DataClass/user.dart';

@JsonSerializable(explicitToJson: true)
class Car {
  String? carId;
  String? brand;
  String? category;
  int? dateFirstFabrication;
  int? mileage;
  String? model;
  String? gearboxType;
  String? motor;
  String? licensePlate; 
  int? doorsNumber;
  int? seatsNumber;
  String? description;
  String? restriction; 
  List<String> ?equipmentAndOptions;
  List<String>? photos;
  int? pricePerHour;
  Address? address;
  String? status;
    double? lat; 
  double? lon; 
  RentDemand? rentDemand;
  int? min ; 
  int? max ; 
  User? renter;

  Car({
    this.carId,
    this.brand,
    this.category,
    this.dateFirstFabrication,
    this.mileage,
    this.model,
    this.gearboxType,
    this.motor,
    this.licensePlate, 
    this.doorsNumber,
    this.seatsNumber,
    this.description,
    this.restriction, 
    this.equipmentAndOptions,
    this.photos,
    this.pricePerHour,
    this.address,
    this.status,
    this.rentDemand,
    this.renter,
    this.lat,
    this.lon,
    this.max,
    this.min });

  factory Car.fromJson(Map<String, dynamic> json) {
    Address add = Address();
    add.country  =  json['place'] ;
        List<String>? equipmentAndOptions = (json['equipement'] as String?)?.split('//');
    return Car(
      carId: json['carIdentifier'] as String?,
      brand: json['brand'] as String?,
      category: json['category'] as String?,
      dateFirstFabrication: json['dateFirstFabrication']  as int?,
      mileage: json['mileAge'] as int?,
       min: int.parse(json['minDuration'] ) as int?,
        max:int.parse( json['maxDuration'] )as int?,
      model: json['model'] as String?,
      gearboxType: json['gearBoxType'] as String?,
      motor: json['motor'] as String?,
      licensePlate: json['licensePlate'] as String?, 
      doorsNumber: json['doorsNumber'] as int?,
      seatsNumber: json['seatsNumber'] as int?,
      description: json['description'] as String?,
      restriction: json['restriction'] as String?, 
     // equipmentAndOptions: (json['equipmentAndOptions'] as List<dynamic>?)?.map((e) => e as String).toList(),   
      equipmentAndOptions: equipmentAndOptions,

      photos: (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      pricePerHour: json['pricePerHour'] as int?,
      address:  add,
      status: json['carStatus'] as String?,
      rentDemand: json['rentDemand'] != null ? RentDemand.fromJson(json['rentDemand'] as Map<String, dynamic>) : null,
      renter: json['renter'] != null ? User.fromJson(json['renter'] as Map<String, dynamic>) : null,
       lat: double.parse( json['latitude'])  ,
      lon: double.parse( json['longitude']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carIdentifier': carId,
      'brand': brand,
      'category': category,
      'dateFirstFabrication': dateFirstFabrication,
      'mileAge': mileage,
      'model': model,
      'gearboxType': gearboxType,
      'motor': motor,
      'licensePlate': licensePlate,
      'doorsNumber': doorsNumber,
      'seatsNumber': seatsNumber,
      'description': description,
      'restriction': restriction, 
      'equipmentAndOptions': equipmentAndOptions,
      'photos': photos,
      'pricePerHour': pricePerHour,
      'address': address?.toJson(),
      'carStatus': status,
      'rentDemand': rentDemand?.toJson(),
      'renter': renter?.toJson(),
    };
  }
}
