import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoproviderapp/show_dialogue_add_button.dart';
import 'package:todoproviderapp/todo_provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;

    double fontSize;
    EdgeInsets padding;

    if(orientation == Orientation.portrait){
      if(screenWidth < 360){
        fontSize = 14;
        padding = EdgeInsets.all(8);
      }else if(screenWidth < 600){
        fontSize = 18;
        padding = EdgeInsets.all(16);
      }else{
        fontSize = 22;
        padding = EdgeInsets.all(24);
      }
    }else{
      if(screenWidth < 360){
        fontSize = 16;
        padding = EdgeInsets.all(8);
      }else{
        fontSize = 20;
        padding = EdgeInsets.all(16);
      }

    }

    return Consumer<ToDoProviderTaskNumbers>(
      builder: (context, showDialogueAddButtonTask, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Text("Task Number: ${showDialogueAddButtonTask.tasks.length}",style: TextStyle(fontSize: fontSize+2),),
              Expanded(
                child: ListView.builder(
                  itemCount: showDialogueAddButtonTask.tasks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding.left),
                      child: Card(
                        child: ListTile(
                          title: Text('${index+1}: ${showDialogueAddButtonTask.tasks[index]}',style: TextStyle(fontSize: fontSize),),
                          trailing: IconButton(onPressed: (){
                            showDialogueAddButtonTask.removeTask(index);
                            print(showDialogueAddButtonTask.tasks);
                          }, icon: Icon(Icons.delete_forever_outlined,size: fontSize+4,)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialogueAddButton(context);
          },
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.add,size: fontSize+4,),
        ),
      ),
    );
  }

}
