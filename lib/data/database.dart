import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List todoList = [];

  // Reference the box
  final _myBox = Hive.box('myBox');

  // Run this method if this is the first time ever opening this app
  void createInitData(){
    todoList = [
      ['Make Tutorial', false],
      ['Do Exercise', false],
    ];
  }

  // load the data from the database
  void loadDatabase(){
    todoList = _myBox.get('TODOLIST');
  }

  // update the database
  void updateDatabase(){
    _myBox.put('TODOLIST', todoList);
  }
}