import 'package:flutter_todo/data/model/todo.dart';
import '../../domain/entity/todo_domain.dart';
import '../../domain/repository/todo_repository.dart';
import '../datasource/crud_datasource.dart';

class TodoRepositoryImpl extends TodoRepository {
  final CRUDDataSource dataSource;
  TodoRepositoryImpl(this.dataSource);

  @override
  void addTodo(TodoEntity todo) {
    return dataSource.saveTodo(
        TodoModel.fromEntity(todo));
  }

  @override
  void toggleCompleteTodo(TodoEntity todo) {
    return dataSource.updateTodo(todo.id!,
        TodoModel.fromEntity(todo));
  }

  @override
  void deleteTodo(int id) {
    return dataSource.deleteTodo(id);
  }

  @override
  Future<List<TodoEntity>> getTodoList() async {
    return await dataSource.getAllTodoList();
  }

  @override
  Future<List<TodoEntity>> getSelectedTodosList(int value) async {
    return await dataSource.getSelectedTodos(value);
  }
}
