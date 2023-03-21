// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_file.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileCollectionAdapter extends TypeAdapter<FileCollection> {
  @override
  final int typeId = 3;

  @override
  FileCollection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileCollection(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    )..id = fields[3] as int?;
  }

  @override
  void write(BinaryWriter writer, FileCollection obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.pdfName)
      ..writeByte(1)
      ..write(obj.pdf)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileCollectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
