import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_learning_u1/add_todo.dart';
import 'package:hive_learning_u1/todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  Box todoBox = Hive.box<Todo>('todo');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Flutter Hive ToDo') ,
      ),
      body: ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, Box box, widget){
          if(box.isEmpty){
            return Center(
              child: Text('Nothing to do!'),
            );
          }else{
            return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: box.length,
                itemBuilder: (context, index){
                  Todo todo = box.getAt(index);
                  return Card(
                    
                    child: ListTile(

                      title: Text(todo.title, style: TextStyle(
                        fontSize: 20,
                        fontWeight: todo.isCompleted ? FontWeight.normal :FontWeight.bold,
                        color: todo.isCompleted ? Colors.grey : Colors.black,
                        decoration: todo.isCompleted? TextDecoration.lineThrough : TextDecoration.none,
                      ),),
                      leading: Checkbox(value: todo.isCompleted, onChanged: (value){
                        Todo newTodo = Todo(
                          title: todo.title,
                          //exclamation to ensure its not null
                          isCompleted: value!,
                        );
                        box.putAt(index, newTodo);
                      } ,),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.grey,),
                        onPressed: (){
                          box.deleteAt(index);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task has been deleted successfully'),));

                        },
                      ),
                    ),
                  );
                });
          }
        } ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddToDo()));
        },
      ),
    );
  }
}
