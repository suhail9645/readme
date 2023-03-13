// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_story.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryAdapter extends TypeAdapter<Story> {
  @override
  final int typeId = 1;

  @override
  Story read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Story(
      storyname: fields[1] as String,
      authorname: fields[2] as String,
      story: fields[5] as String,
      category: fields[4] as String,
      image: fields[3] as String,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Story obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.storyname)
      ..writeByte(2)
      ..write(obj.authorname)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.story);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
