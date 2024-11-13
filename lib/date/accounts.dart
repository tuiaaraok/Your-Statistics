import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'accounts.g.dart';

@HiveType(typeId: 1)
class Accounts {
  @HiveField(0)
  Uint8List? imageContent;
  @HiveField(1)
  String? orderType;
  @HiveField(2)
  String? customer;
  @HiveField(3)
  String? login;
  @HiveField(4)
  String? password;

  Accounts({
    this.imageContent,
    this.orderType,
    this.customer,
    this.login,
    this.password,
  });
}
