// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarInfoAdapter extends TypeAdapter<CalendarInfo> {
  @override
  final int typeId = 2;

  @override
  CalendarInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalendarInfo(
      day: (fields[0] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<DayIs>())),
    );
  }

  @override
  void write(BinaryWriter writer, CalendarInfo obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.day);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DayIsAdapter extends TypeAdapter<DayIs> {
  @override
  final int typeId = 3;

  @override
  DayIs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayIs(
      name: fields[0] as String?,
      note: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DayIs obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayIsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
