import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:todo_list/component/task_details.dart';
import 'package:todo_list/component/task_tail.dart';
import 'package:todo_list/utils/extensions.dart';

import '../data/models/task.dart';
import '../providers/task/tasks_provider.dart';

class Task extends ConsumerWidget {
  const Task({
    super.key,
    required this.taskList,
  });

  final List<TaskResp> taskList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size deviceSize = context.deviceSize;
    return Container(
      height: 200,
      width: deviceSize.width,
      decoration: BoxDecoration(
        color: Colors.amber[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (context, int index) {
          return InkWell(
            onTap: () async {
              SmartDialog.show(
                alignment: Alignment.bottomCenter,
                builder: (ctx) {
                  return TaskDetails(
                    task: taskList[index],
                    removeFunc: () async {
                      await ref.read(tasksProvider.notifier).deleteTask(taskList[index]).then((value) {
                        SmartDialog.showToast("刪除成功");
                        SmartDialog.dismiss();
                      });
                    },
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TaskTail(
                taskResp: taskList[index],
                onCompleted: (value) async {
                  await ref.read(tasksProvider.notifier).updateTask(taskList[index]).then((value) {
                    SmartDialog.showToast("修改成功");
                  });
                },
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: Colors.red[200],
          height: 1,
          thickness: 1.5,
        ),
        itemCount: taskList.length,
      ),
    );
  }
}
