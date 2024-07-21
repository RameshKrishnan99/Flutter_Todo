import 'package:flutter_todo/domain/entity/todo_domain.dart';
import 'package:flutter_todo/domain/repository/todo_repository.dart';

class DeleteTodoUseCase {
  final TodoRepository repository;
  DeleteTodoUseCase(this.repository);

  void execute(int id) {
    return repository.deleteTodo(id);
  }
}
