import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:todo_list/data/data.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key, required this.task, this.removeFunc});

  final TaskResp task;
  final Function()? removeFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            right: 12,
            top: 12,
            child: IconButton(
              onPressed: removeFunc,
              icon: const Icon(Icons.delete),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultTextStyle(
                    style: const TextStyle(color: Colors.black),
                    child: Column(
                      children: [
                        Text(task.title),
                        const Gap(10),
                        Text(task.time),
                        const Gap(20),
                        Container(height: 2, color: Colors.purple[500]),
                        const Gap(20),
                        Text(task.note),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
