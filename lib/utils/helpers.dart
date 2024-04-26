import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/utils/extensions.dart';

import '../providers/date_provider.dart';
import '../providers/task/tasks_provider.dart';

@immutable
class Helpers {
  const Helpers._();

  static void selectDate(BuildContext context, WidgetRef ref) async {
    final initialDate = ref.read(dateProvider);
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2060),
    );

    if (pickedDate != null) {
      ref.read(dateProvider.notifier).state = pickedDate;
      ref.read(tasksProvider.notifier).getTasks(ref.read(dateProvider.notifier).state.timeToString().split(" ").first);
    }
  }

  static String dateFormatter(DateTime date) {
    try {
      return DateFormat.yMMMd().format(date);
    } catch (e) {
      return DateFormat.yMMMd().format(
        DateTime.now(),
      );
    }
  }
}
