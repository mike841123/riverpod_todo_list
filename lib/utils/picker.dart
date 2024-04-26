import 'package:flutter/material.dart';

enum Picker {
  date(Icon(Icons.calendar_month_rounded)),
  time(Icon(Icons.timer));

  final Icon icon;

  const Picker(this.icon);
}
