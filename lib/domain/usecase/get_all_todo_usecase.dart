import 'package:flutter_todo/domain/entity/todo_domain.dart';
import 'package:flutter_todo/domain/repository/todo_repository.dart';

class GetAllTodoUseCase {
  final TodoRepository repository;
  GetAllTodoUseCase(this.repository);

  Future<List<TodoEntity>> execute() async {
    return await repository.getTodoList();
  }
}
