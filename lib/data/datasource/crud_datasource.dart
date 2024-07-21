
import '../../domain/entity/todo_domain.dart';
import '../database/app_database.dart';
import '../database/dao/todo_dao.dart';
import '../model/todo.dart';

class CRUDDataSource {
  late TodoDao todoDao;

  Future<void> initialize(AppDatabase appDatabase) async {
    todoDao = appDatabase.todoDao;
  }

  void saveTodo(TodoModel todo) async {
    try {
      await todoDao.insertTodo(todo);
    } catch (error) {
      print(error);
    }
  }

  
  void updateTodo(int id, TodoModel todo) async {
    try {
      todo.id = id;
      await todoDao.updateTodo(todo);
    } catch (error) {
      print(error);
    }
  }

  
  void deleteTodo(int id) async {
    try {
      await todoDao.deleteTodo(id);
    } catch (error) {
      print(error);
    }
  }

  
  Future<List<TodoEntity>> getAllTodoList() async {
    var list =  await todoDao.getAllTodos();
    return list;
  }

  Future<List<TodoEntity>> getSelectedTodos(int value) async {
    var list =  await todoDao.getSelectedTodos(value);
    return list;
  }
}
