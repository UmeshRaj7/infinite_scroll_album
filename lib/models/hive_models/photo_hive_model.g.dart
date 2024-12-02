// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhotoHiveModelAdapter extends TypeAdapter<PhotoHiveModel> {
  @override
  final int typeId = 1;

  @override
  PhotoHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhotoHiveModel(
      id: fields[0] as int,
      albumId: fields[1] as int,
      url: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PhotoHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.albumId)
      ..writeByte(2)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
