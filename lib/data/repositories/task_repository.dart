import 'package:todo_list/data/data.dart';

abstract class TaskRepository {
  Future<void> addTask(TaskResp task);
  Future<void> updateTask(TaskResp task);
  Future<void> deleteTask(TaskResp task);
  Future<List<TaskResp>> getAllTasks(String selectDate);
}
