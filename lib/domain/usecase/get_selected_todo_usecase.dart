import 'package:flutter_todo/domain/entity/todo_domain.dart';
import 'package:flutter_todo/domain/repository/todo_repository.dart';

class GetSelectedTodoUseCase {
  final TodoRepository repository;
  GetSelectedTodoUseCase(this.repository);

  Future<List<TodoEntity>> execute(int value) async {
    return await repository.getSelectedTodosList(value);
  }
}
