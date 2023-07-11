import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_hive/data/database.dart';
import 'package:todo_hive/util/dialog_box.dart';
import 'package:todo_hive/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Reference the hive box
  final _myBox = Hive.box('myBox');

  final _controller = TextEditingController();

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {

    if(_myBox.get('TODOLIST') == null){
      db.createInitData();
    } else{
      db.loadDatabase();
    }

    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
    });
    db.updateDatabase();
    Navigator.of(context).pop();
    _controller.clear();
  }

  void cancelNewTask() {
    Navigator.of(context).pop();
    _controller.clear();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: cancelNewTask,
        );
      },
    );
  }

  // Delete Task
  void deleteTask(int index){
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('To Do'),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
