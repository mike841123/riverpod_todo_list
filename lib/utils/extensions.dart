import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get _theme => Theme.of(this);
  TextTheme get textTheme => _theme.textTheme;
  ColorScheme get colorScheme => _theme.colorScheme;
  Size get deviceSize => MediaQuery.sizeOf(this);
}

/// DateTime 擴充功能
extension DateFormatExtension on DateTime {
  /// 日期類型轉換字串格式的時間
  String timeToString() => DateFormat('yyyy-MM-dd HH:mm:ss').format(this);

  /// 當前 DateTime 當天的第一個時間戳
  int dayStartMillisecondsSinceEpoch() => DateTime(year, month, day).millisecondsSinceEpoch;
}