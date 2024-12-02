// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlbumHiveModelAdapter extends TypeAdapter<AlbumHiveModel> {
  @override
  final int typeId = 0;

  @override
  AlbumHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlbumHiveModel(
      id: fields[0] as int,
      title: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AlbumHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
