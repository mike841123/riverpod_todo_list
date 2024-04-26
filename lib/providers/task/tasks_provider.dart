import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/providers/date_provider.dart';
import 'package:todo_list/providers/task/task_notifier.dart';
import 'package:todo_list/providers/task/task_state.dart';
import 'package:todo_list/utils/extensions.dart';

import '../../data/repositories/task_repository_provider.dart';

final tasksProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  String dateTime = ref.read(dateProvider.notifier).state.timeToString().split(" ").first;

  return TaskNotifier(repository, dateTime);
});
