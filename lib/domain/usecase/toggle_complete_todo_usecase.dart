import 'package:flutter_todo/domain/entity/todo_domain.dart';
import 'package:flutter_todo/domain/repository/todo_repository.dart';

class ToggleCompleteTodoUseCase {
  final TodoRepository repository;
  ToggleCompleteTodoUseCase(this.repository);

  void execute(TodoEntity todoDomain) {
    return repository.toggleCompleteTodo(todoDomain);
  }
}
