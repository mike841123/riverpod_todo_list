import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_list/utils/extensions.dart';
import 'package:todo_list/utils/picker.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    required this.picker,
  });

  final TextEditingController controller;
  final String hintText;
  final String title;
  final Picker picker;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime initialDate;
  late DateTime firstDate;
  late DateTime lastDate;
  late Color bgColor;
  late Color borderColor;
  late EdgeInsetsGeometry contentPadding;
  late double borderWidth;
  late double iconSize;
  late String hint;
  DateTime? _selectedDate; // 當前選擇的日期

  @override
  void initState() {
    super.initState();
    initialDate = DateTime.now();
    firstDate = DateTime(1900);
    lastDate = DateTime(2100);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.title,
        ),
        const Gap(10),
        TextField(
          onTap: () async {
            switch (widget.picker) {
              case Picker.time:
                _showTimePicker();
                break;
              case Picker.date:
                _showDatePicker();
                break;
            }
          },
          controller: widget.controller,
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: widget.hintText,
            suffixIcon: widget.picker.icon,
          ),
        ),
      ],
    );
  }

  Future<void> _showTimePicker() async {
    TimeOfDay? timeOfDay = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      if (timeOfDay != null) {
        setState(() {
          widget.controller.text = timeOfDay.format(context);
        });
      }
    });
  }

  Future<void> _showDatePicker() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      /// 按取消或者關閉日期彈窗才不會清空選擇的
      if (date != null && date != _selectedDate) {
        setState(() {
          _selectedDate = date;
          widget.controller.text = date.timeToString().split(" ").first;
        });
      }
    });
  }
}
