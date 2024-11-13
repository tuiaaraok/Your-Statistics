// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_an_account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SelectAnAccountAdapter extends TypeAdapter<SelectAnAccount> {
  @override
  final int typeId = 5;

  @override
  SelectAnAccount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SelectAnAccount(
      selectList: (fields[0] as List<String>?)?.toSet(),
      images: (fields[1] as List<dynamic>?)?.map((e) => e as Uint8List).toSet(),
    );
  }

  @override
  void write(BinaryWriter writer, SelectAnAccount obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.selectList?.toList())
      ..writeByte(1)
      ..write(obj.images?.toList());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectAnAccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
