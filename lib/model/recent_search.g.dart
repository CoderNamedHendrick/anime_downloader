// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_search.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentSearchAdapter extends TypeAdapter<RecentSearch> {
  @override
  final int typeId = 0;

  @override
  RecentSearch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentSearch()
      ..title = fields[0] as String
      ..imgUrl = fields[1] as String
      ..link = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, RecentSearch obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.imgUrl)
      ..writeByte(2)
      ..write(obj.link);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentSearchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
