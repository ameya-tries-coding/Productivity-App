// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_completion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskCompletionAdapter extends TypeAdapter<TaskCompletion> {
  @override
  final int typeId = 4;

  @override
  TaskCompletion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskCompletion()
      ..id = fields[0] as String
      ..taskId = fields[1] as String
      ..date = fields[2] as DateTime
      ..isCompleted = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, TaskCompletion obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskCompletionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
