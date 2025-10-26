import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoproviderapp/todo_provider.dart';

void showDialogueAddButton(BuildContext context) {
  final TextEditingController taskController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Task'),
        content: TextField(
          controller: taskController,
          autofocus: true,
          decoration: InputDecoration(hintText: 'Enter Task'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (taskController.text.trim().isNotEmpty) {
                Provider.of<ToDoProviderTaskNumbers>(context, listen: false).addTask(taskController.text.trim());
              }
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      );
    },
  );
}