import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/presentation/bloc/add/todo_add_state.dart';
import 'package:flutter_todo/presentation/bloc/todo_event.dart';

import '../../../domain/entity/todo_domain.dart';
import '../../../domain/usecase/add_todo_usecase.dart';

class AddBloc extends Bloc<TodoEvent, TodoAddState> {
  final AddTodoUseCase addTodoUseCase;

  AddBloc({required this.addTodoUseCase}) : super(TodoAddLoadingState()) {
    on<TodoItemAddedEvent>(_onItemAdded);
  }

  void _onItemAdded(
      TodoItemAddedEvent event, Emitter<TodoAddState> emit) async {
    emit(TodoAddLoadingState());
    try {
      var todoDomain = TodoEntity(event.todo.id, event.todo.title,
          event.todo.description, event.todo.isCompleted);
      addTodoUseCase.execute(event.todo);
      emit(const TodoAddedState());
    } catch (_) {
      emit(const TodoAddErrorState());
    }
  }
}
