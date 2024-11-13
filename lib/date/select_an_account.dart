import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'select_an_account.g.dart';

@HiveType(typeId: 5)
class SelectAnAccount {
  @HiveField(0)
  Set<String>? selectList;
  @HiveField(1)
  Set<Uint8List>? images;
  SelectAnAccount({this.selectList, this.images});
}
