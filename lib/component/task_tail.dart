import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_list/data/data.dart';

class TaskTail extends StatelessWidget {
  const TaskTail({super.key, required this.taskResp, this.onCompleted});

  final TaskResp taskResp;
  final Function(bool?)? onCompleted;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            const Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(taskResp.title, style: const TextStyle(color: Colors.black, fontSize: 18)),
                Text("${taskResp.date} ${taskResp.time}", style: const TextStyle(color: Colors.black, fontSize: 14)),
              ],
            )
          ],
        ),
        Checkbox(
          value: taskResp.isCompleted,
          onChanged: onCompleted,
          checkColor: Colors.grey,
        ),
      ],
    );
  }
}
