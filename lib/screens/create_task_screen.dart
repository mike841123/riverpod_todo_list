import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/component/custom_text_field.dart';
import 'package:todo_list/data/data.dart';
import 'package:todo_list/utils/picker.dart';

import '../component/date_picker.dart';
import '../config/routes/routes_location.dart';
import '../providers/task/tasks_provider.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Task"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(hintText: "Task Title", title: "Task Title",controller: _titleController),
                const Gap(20),
                DatePicker(hintText: "please select date", title: "Date", controller: _dateController, picker: Picker.date),
                const Gap(20),
                DatePicker(hintText: "please select date", title: "Date", controller: _timeController, picker: Picker.time),
                const Gap(20),
                CustomTextField(hintText: "Notes", title: "Notes", maxLines: 10,controller: _noteController),
                const Gap(20),
                ElevatedButton(
                  onPressed: () => _createTask(),
                  child: const Text("Create New Task"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createTask() async {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      final task = TaskResp(
        title: _titleController.text,
        time: _timeController.text,
        date: _dateController.text,
        note: _noteController.text,
        isCompleted: false,
      );

      await ref.read(tasksProvider.notifier).createTask(task).then((value) {
        context.go(RouteLocation.home);
      });
    } else {
      print("wrong");
    }
  }
}
