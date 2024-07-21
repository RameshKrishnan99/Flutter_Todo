import 'package:flutter_todo/data/model/todo.dart';
import 'package:flutter_todo/data/datasource/crud_datasource.dart';
import 'package:flutter_todo/domain/entity/todo_domain.dart';

class MockDatabase extends CRUDDataSource{

  static final Map<int,TodoModel> _todoList = {};
  int latestId = 0;
  @override
  void deleteAllTodoList() {
    _todoList.clear();
  }

  @override
  void deleteTodo(int id) {
    _todoList.remove(id);
  }

  @override
  Future<List<TodoEntity>> getAllTodoList() async {
    var todoList =  _todoList.values.map((e) => TodoEntity(e.id, e.title, e.description, e.isCompleted))
        .toList();
    return todoList;
  }

  @override
  void saveTodo(TodoEntity todo) {
    int newLatestId = latestId + 1;
    var todoEntity = TodoModel(
        id: newLatestId,
        title: todo.title,
        description: todo.description,
        isCompleted: todo.isCompleted);
    _todoList[newLatestId] = todoEntity;
    latestId = newLatestId;
  }

  @override
  void updateTodo(int id, TodoEntity todo) {
    _todoList[todo.id!] = TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        isCompleted: todo.isCompleted);
  }

}