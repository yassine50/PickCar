import 'package:json_annotation/json_annotation.dart';
import 'package:pickcar/DataClass/address.dart';
import 'package:pickcar/DataClass/notification.dart';
import 'package:pickcar/Tools/Constants.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String? userIdentifier;
  String? email;
  String? phone;
  String? cni;
  String? passportIdentifier;
  String? firstName;
  String? lastName;
  DateTime? dateOfBirth;
  String? nationality;
  String? role;
  String? profileImage;
  List<String>? photos;
  List<Notification>? notifications;
  String? verificationID;
  Address? address;
  String? password; 
  String? jwtToken; 
  String? currentMode;
  String? customerIdentifier; 
  String? renterIdentifier; 
  int? rentCount ;
  double? totlaPrice ; 

  User({
    this.userIdentifier,
    this.email,
    this.phone,
    this.cni,
    this.passportIdentifier,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.nationality,
    this.role,
    this.profileImage,
    this.photos,
    this.notifications,
    this.verificationID,
    this.address,
    this.password,
    this.jwtToken,
    this.currentMode,
    this.customerIdentifier, 
    this.renterIdentifier, 
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  static User _$UserFromJson(Map<String, dynamic> json) {
    return User(
      userIdentifier: json['userIdentifier'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      cni: json['cni'] as String?,
      passportIdentifier: json['passportIdentifier'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      dateOfBirth: json['birthDate'] != null ? DateTime.parse(json['birthDate'] as String) : null,
      nationality: json['nationality'] as String?,
      role: json['role'] as String?,
      profileImage: json['profileImage'] as String?,
      photos: (json['photos'] as List?)?.map((e) => e as String).toList(),
      notifications: (json['notifications'] as List?)?.map((e) => Notification.fromJson(e as Map<String, dynamic>)).toList(),
      verificationID: json['verificationID'] as String?,
      address: json['address'] != null ? Address.fromJson(json['address'] as Map<String, dynamic>) : null,
      password: json['password'] as String?,
      jwtToken: json['jwt-token'] as String?,
      currentMode: json['currentMode'] as String?,
      customerIdentifier: json['customerIdentifier'] as String?, 
      renterIdentifier: json['renterIdentifier'] as String?, 
    );
  }

  static Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
        'userIdentifier': instance.userIdentifier,
        'email': instance.email,
        'phone': instance.phone,
        'cni': instance.cni,
        'passportIdentifier': instance.passportIdentifier,
        'firstName': instance.firstName,
        'lastName': instance.lastName,
        'birthDate': instance.dateOfBirth?.toIso8601String(),
        'nationality': instance.nationality,
        'role': instance.role,
        'profileImage': instance.profileImage,
        'photos': instance.photos,
        'notifications': instance.notifications?.map((e) => e.toJson()).toList(),
        'verificationID': instance.verificationID,
        'address': instance.address?.toJson(),
        'password': instance.password,
        'jwt-token': instance.jwtToken,
        'currentMode': instance.currentMode,
        'customerIdentifier': instance.customerIdentifier,
        'renterIdentifier': instance.renterIdentifier, 
      };
}
