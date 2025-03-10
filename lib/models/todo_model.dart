import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  TodoModel(
      {required this.date,
      this.description,
      required this.status,
      required this.title,
      this.isScheduled = false});
  @HiveField(0)
  String title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  String status;
  @HiveField(4)
  bool isScheduled;
}

// status => P(Pending) : O(Overdue) : C(Complete)
