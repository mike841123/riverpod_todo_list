import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/data/data.dart';
import 'package:todo_list/providers/task/task_state.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  final TaskRepository _repository;
  final String dateTime; // 傳入date

  TaskNotifier(this._repository, this.dateTime) : super(const TaskState.initial()) {
    getTasks(dateTime);
  }

  /// 創建任務
  Future<void> createTask(TaskResp task) async {
    try {
      await _repository.addTask(task);
      getTasks(task.date);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// 刪除任務
  Future<void> deleteTask(TaskResp task) async {
    try {
      await _repository.deleteTask(task);
      getTasks(task.date);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// 更新任務
  Future<void> updateTask(TaskResp task) async {
    try {
      final isCompleted = !task.isCompleted;
      final updatedTask = task.copyWith(isCompleted: isCompleted);
      await _repository.updateTask(updatedTask);
      getTasks(task.date);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// 取得任務列表
  void getTasks(String dateTime) async {
    try {
      final tasks = await _repository.getAllTasks(dateTime);
      state = state.copyWith(tasks: tasks);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
