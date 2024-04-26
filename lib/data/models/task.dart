import 'package:equatable/equatable.dart';

class TaskResp extends Equatable {
  final int? id;
  final String title;
  final String note;
  final String time;
  final String date;
  final bool isCompleted;

  const TaskResp({
    this.id,
    required this.title,
    required this.time,
    required this.date,
    required this.note,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "title": title,
      "note": note,
      "time": time,
      "date": date,
      "isCompleted": isCompleted ? 1 : 0,
    };
  }

  factory TaskResp.fromJson(Map<String, dynamic> map) {
    return TaskResp(
      id: map["id"],
      title: map["title"],
      note: map["note"],
      time: map["time"],
      date: map["date"],
      isCompleted: map["isCompleted"] == 1 ? true : false,
    );
  }

  @override
  List<Object> get props {
    return [
      title,
      note,
      time,
      date,
      isCompleted,
    ];
  }

  TaskResp copyWith({
    int? id,
    String? title,
    String? note,
    String? time,
    String? date,
    bool? isCompleted,
  }) {
    return TaskResp(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      time: time ?? this.time,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
