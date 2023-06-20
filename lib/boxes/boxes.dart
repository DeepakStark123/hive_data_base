import 'package:hive/hive.dart';
import 'package:my_app/models/task_model.dart';

class Boxes {
  static Box<TaskModel> getData() => Hive.box<TaskModel>('tasks');
}
