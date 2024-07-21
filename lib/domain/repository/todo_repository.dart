import '../entity/todo_domain.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> getTodoList();
  Future<List<TodoEntity>> getSelectedTodosList(int value);
  void addTodo(TodoEntity todo);
  void toggleCompleteTodo(TodoEntity todo);
  void deleteTodo(int id);
}
