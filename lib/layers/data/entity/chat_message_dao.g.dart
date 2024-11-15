// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_dao.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMessageDAOAdapter extends TypeAdapter<ChatMessageDAO> {
  @override
  final int typeId = 0;

  @override
  ChatMessageDAO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessageDAO(
      roomId: fields[0] as String,
      messageId: fields[1] as String,
      sender: fields[2] as String,
      content: fields[3] as String,
      timestamp: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessageDAO obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.roomId)
      ..writeByte(1)
      ..write(obj.messageId)
      ..writeByte(2)
      ..write(obj.sender)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageDAOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
