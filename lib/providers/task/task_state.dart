import 'package:equatable/equatable.dart';

import '../../data/models/task.dart';

class TaskState extends Equatable {
  final List<TaskResp> tasks;

  const TaskState({
    required this.tasks,
  });
  const TaskState.initial({
    this.tasks = const [],
  });

  TaskState copyWith({
    List<TaskResp>? tasks,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object> get props => [tasks];
}
