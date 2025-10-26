import 'package:flutter/widgets.dart';

class ToDoProviderTaskNumbers extends ChangeNotifier{
  List<String> tasks=[];

  void addTask(String task){
    tasks.add(task);
    notifyListeners();
  }
  void removeTask(int index){
    tasks.removeAt(index);
    notifyListeners();
  }
}