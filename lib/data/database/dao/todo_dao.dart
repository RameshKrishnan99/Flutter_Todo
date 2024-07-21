import 'package:floor/floor.dart';
import '../../model/todo.dart';

@dao
abstract class TodoDao{
  @Query('SELECT * FROM TodoEntity')
  Future<List<TodoModel>> getAllTodos();

  @Query('SELECT * FROM TodoEntity where isCompleted = :value')
  Future<List<TodoModel>> getSelectedTodos(int value);

  @insert
  Future<void> insertTodo(TodoModel todoModel);

  @update
  Future<void> updateTodo(TodoModel todoModel);

  @Query('Delete FROM TodoEntity where id = :id')
  Future<void> deleteTodo(int id);
}