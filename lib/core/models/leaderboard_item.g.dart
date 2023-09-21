// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LeaderboardItemAdapter extends TypeAdapter<LeaderboardItem> {
  @override
  final int typeId = 0;

  @override
  LeaderboardItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LeaderboardItem(
      name: fields[0] as String,
      difficulty: fields[1] as String,
      score: fields[2] as int,
      width: fields[3] as int,
      height: fields[4] as int,
      uploaded: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LeaderboardItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.difficulty)
      ..writeByte(2)
      ..write(obj.score)
      ..writeByte(3)
      ..write(obj.width)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.uploaded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaderboardItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
