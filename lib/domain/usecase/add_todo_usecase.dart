import 'package:flutter_todo/domain/entity/todo_domain.dart';
import 'package:flutter_todo/domain/repository/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository repository;
  AddTodoUseCase(this.repository);

  void execute(TodoEntity todoDomain) {
    return repository.addTodo(todoDomain);
  }
}
