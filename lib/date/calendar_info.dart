import 'package:hive/hive.dart';
part 'calendar_info.g.dart';

@HiveType(typeId: 2)
class CalendarInfo {
  @HiveField(0)
  Map<String, List<DayIs>> day = {};
  CalendarInfo({required this.day});
}

@HiveType(typeId: 3)
class DayIs {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? note;
  DayIs({
    this.name,
    this.note,
  });
}
