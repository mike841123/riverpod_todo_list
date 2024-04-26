import 'package:todo_list/data/repositories/task_repository.dart';

import '../datasource/task_datasource.dart';
import '../models/task.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDatasource _datasource;
  TaskRepositoryImpl(this._datasource);

  @override
  Future<void> addTask(TaskResp task) async {
    try {
      await _datasource.addTask(task);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> deleteTask(TaskResp task) async {
    try {
      await _datasource.deleteTask(task);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<List<TaskResp>> getAllTasks(String selectDate) async {
    try {
      return await _datasource.getAllTasks(selectDate);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> updateTask(TaskResp task) async {
    try {
      await _datasource.updateTask(task);
    } catch (e) {
      throw '$e';
    }
  }
}
