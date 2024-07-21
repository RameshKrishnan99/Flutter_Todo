import 'package:equatable/equatable.dart';
import 'package:flutter_todo/domain/entity/todo_domain.dart';

class TodoModel extends Equatable {

  const TodoModel({required this.todoList});

  final List<TodoEntity> todoList;

  @override
  List<Object> get props => [todoList];
}