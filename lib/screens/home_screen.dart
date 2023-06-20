import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/boxes/boxes.dart';
import 'package:my_app/controllers/controller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/task_model.dart';
import '../utils/common.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task App"),
        actions: [
          IconButton(
              onPressed: () async {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Form(
                      key: formKey,
                      child: AlertDialog(
                        title: const Text('Add Task'),
                        actions: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Title"),
                              5.heightBox,
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter tiele';
                                  }
                                  return null;
                                },
                                controller: homeController.titleController,
                                decoration: InputDecoration(
                                  hintText: "Enter title",
                                  border: textfieldBorder,
                                ),
                              ),
                              10.heightBox,
                              const Text("Description"),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter description';
                                  }
                                  return null;
                                },
                                controller:
                                    homeController.descriptionController,
                                decoration: InputDecoration(
                                    hintText: "Enter description",
                                    border: textfieldBorder),
                              ),
                              20.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        homeController.addTask();
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text("Add"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      homeController.emptyData();
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ValueListenableBuilder<Box<TaskModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList()..cast<TaskModel>();
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].title.toString()),
                    subtitle: Text(data[index].description.toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              homeController.deleteTask(data[index]);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () {
                              homeController.titleController.text =
                                  data[index].title;
                              homeController.descriptionController.text =
                                  data[index].description;
                              showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Form(
                                    key: formKey,
                                    child: AlertDialog(
                                      title: const Text('Add Task'),
                                      actions: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Title"),
                                            5.heightBox,
                                            TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter tiele';
                                                }
                                                return null;
                                              },
                                              controller: homeController
                                                  .titleController,
                                              decoration: InputDecoration(
                                                hintText: "Enter title",
                                                border: textfieldBorder,
                                              ),
                                            ),
                                            10.heightBox,
                                            const Text("Description"),
                                            TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter description';
                                                }
                                                return null;
                                              },
                                              controller: homeController
                                                  .descriptionController,
                                              decoration: InputDecoration(
                                                  hintText: "Enter description",
                                                  border: textfieldBorder),
                                            ),
                                            20.heightBox,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      homeController.editTask(
                                                          data[index], index);
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: const Text("Add"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    homeController.emptyData();
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
