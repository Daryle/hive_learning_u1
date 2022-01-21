import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_learning_u1/todo.dart';

class AddToDo extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  Box todoBox = Hive.box<Todo>('todo');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add To Do Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  labelText: "Title", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text != '') {
                    Todo newTodo = Todo(
                      title: titleController.text,
                      isCompleted: false,
                    );
                    todoBox.add(newTodo);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Add ToDo',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
