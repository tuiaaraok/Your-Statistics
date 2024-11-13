import 'package:hive/hive.dart';

part 'plan.g.dart';

@HiveType(typeId: 4)
class Plan {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? followers;
  @HiveField(2)
  String? likes;
  @HiveField(3)
  String? posts;
  Plan({this.name, this.followers, this.likes, this.posts});
}
