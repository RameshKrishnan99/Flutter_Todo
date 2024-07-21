import 'package:equatable/equatable.dart';
import 'package:flutter_todo/domain/entity/todo_domain.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class TodoStartedEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class TodoFilterEvent extends TodoEvent {
  const TodoFilterEvent(this.value);

  final int value;

  @override
  List<Object?> get props => [value];
}

class TodoItemAddedEvent extends TodoEvent {
  const TodoItemAddedEvent(this.todo);

  final TodoEntity todo;

  @override
  List<Object?> get props => [todo];
}

class TodoItemToggleCompletedEvent extends TodoEvent {
  const TodoItemToggleCompletedEvent(this.todo);

  final TodoEntity todo;

  @override
  List<Object?> get props => [todo];
}

class TodoItemDeletedEvent extends TodoEvent {
  const TodoItemDeletedEvent(this.id);

  final int id;

  @override
  List<Object?> get props => [];
}

