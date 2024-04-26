import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/data/data.dart';
import 'package:todo_list/utils/extensions.dart';

import '../component/task.dart';
import '../config/routes/routes_location.dart';
import '../providers/date_provider.dart';
import '../providers/task/tasks_provider.dart';
import '../utils/helpers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(tasksProvider);
    List<TaskResp> notCompletedList = taskState.tasks.where((element) => element.isCompleted == false).toList();
    List<TaskResp> completedList = taskState.tasks.where((element) => element.isCompleted).toList();
    final Size deviceSize = context.deviceSize;
    final date = ref.watch(dateProvider);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                color: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => Helpers.selectDate(context, ref),
                      child: Text(
                        Helpers.dateFormatter(date),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    const Text(
                      "My Todo List",
                      style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Task(taskList: notCompletedList),
                    const Gap(20),
                    const Text(
                      "Completed Task",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const Gap(20),
                    Task(taskList: completedList),
                    const Gap(20),
                    ElevatedButton(
                      onPressed: () => context.push(RouteLocation.createTask),
                      child: const Text("Add New Task"),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
