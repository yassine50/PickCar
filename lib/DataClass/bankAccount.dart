import 'package:json_annotation/json_annotation.dart';
import 'customer.dart';

@JsonSerializable(explicitToJson: true)
class BankAccount {
  String bankAccountIdentifier;
  String bankName;
  String accountHolderName;
  String rib;
  String iban;
  
  // Make the customer field transient during serialization
  @JsonKey(ignore: true)
  Customer customer;

  BankAccount({
    required this.bankAccountIdentifier,
    required this.bankName,
    required this.accountHolderName,
    required this.rib,
    required this.iban,
    required this.customer,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      bankAccountIdentifier: json['bankAccountIdentifier'] as String,
      bankName: json['bankName'] as String,
      accountHolderName: json['accountHolderName'] as String,
      rib: json['rib'] as String,
      iban: json['iban'] as String,
      // Deserialize the customer field manually
      // Assuming customer data is nested under a key called 'customer'
      customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    // Serialize the customer field manually
    final json = {
      'bankAccountIdentifier': bankAccountIdentifier,
      'bankName': bankName,
      'accountHolderName': accountHolderName,
      'rib': rib,
      'iban': iban,
      'customer': customer.toJson(),
    };
    return json;
  }
}
