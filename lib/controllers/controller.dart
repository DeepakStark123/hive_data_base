import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/boxes/boxes.dart';

import '../models/task_model.dart';

class HomeController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List taskList = <TaskModel>[].obs;

  addTask() {
    var task = TaskModel(
        title: titleController.text, description: descriptionController.text);
    final box = Boxes.getData();
    box.add(task);
    task.save();
    emptyData();
  }

  deleteTask(TaskModel task) async {
    await task.delete();
  }

  editTask(TaskModel taskdata, int index) {
    taskdata.title = titleController.text;
    taskdata.description = descriptionController.text;
    taskdata.save();
    emptyData();
  }

  emptyData() {
    titleController.clear();
    descriptionController.clear();
  }
}
