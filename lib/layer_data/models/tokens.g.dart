// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokensAdapter extends TypeAdapter<Tokens> {
  @override
  final int typeId = 0;

  @override
  Tokens read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tokens(
      accessToken: fields[0] as String,
      refreshToken: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Tokens obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.refreshToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokensAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
