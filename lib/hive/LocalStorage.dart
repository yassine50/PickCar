import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pickcar/DataClass/customer.dart';
import 'package:pickcar/DataClass/renter.dart';
import 'package:pickcar/DataClass/user.dart';

class LocalStorage {
  static Future<void> SaveUser(User user) async {
    await Hive.initFlutter();
    await Hive.openBox("user");
    var account = Hive.box('user');
    await account.put('user', user.toJson());
  }


  static Future<Map> GetUser() async {
    await Hive.initFlutter();
    await Hive.openBox("user");
    var box = Hive.box('user');
    Map user = box.get('user');
    return user;
  }

  static Future<void> SaveCustomer(Customer customer )async {
    await Hive.initFlutter();
    await Hive.openBox("customer");
    var account = Hive.box('customer');
    await account.put('customer', customer.toJson());
  }

 static Future<Map> GetCustomer() async {
    await Hive.initFlutter();
    await Hive.openBox("customer");
    var box = Hive.box('customer');
    Map user = box.get('customer');
    return user;
  }

  static Future<void> SaveRenter(Renter renter )async {
    await Hive.initFlutter();
    await Hive.openBox("renter");
    var account = Hive.box('renter');
    await account.put('renter', renter.toJson());
  }

 static Future<Map> GetRenter() async {
    await Hive.initFlutter();
    await Hive.openBox("renter");
    var box = Hive.box('renter');
    Map user = box.get('renter');
    return user;
  }
}
