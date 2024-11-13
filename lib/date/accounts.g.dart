// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountsAdapter extends TypeAdapter<Accounts> {
  @override
  final int typeId = 1;

  @override
  Accounts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Accounts(
      imageContent: fields[0] as Uint8List?,
      orderType: fields[1] as String?,
      customer: fields[2] as String?,
      login: fields[3] as String?,
      password: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Accounts obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.imageContent)
      ..writeByte(1)
      ..write(obj.orderType)
      ..writeByte(2)
      ..write(obj.customer)
      ..writeByte(3)
      ..write(obj.login)
      ..writeByte(4)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
