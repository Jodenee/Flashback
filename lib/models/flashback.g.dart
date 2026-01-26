// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashback.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlashbackAdapter extends TypeAdapter<Flashback> {
  @override
  final int typeId = 0;

  @override
  Flashback read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Flashback(
      text: fields[0] as String,
      latitude: fields[1] as double,
      longitude: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Flashback obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlashbackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
