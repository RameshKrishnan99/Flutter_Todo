import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/presentation/bloc/todo_event.dart';
import 'package:flutter_todo/presentation/bloc/update/todo_update_state.dart';

import '../../../domain/entity/todo_domain.dart';
import '../../../domain/usecase/toggle_complete_todo_usecase.dart';

class UpdateBloc extends Bloc<TodoEvent, TodoUpdateState> {
  final ToggleCompleteTodoUseCase toggleCompleteTodoUseCase;

  UpdateBloc({required this.toggleCompleteTodoUseCase}) : super(TodoUpdateLoadingState()) {
    on<TodoItemToggleCompletedEvent>(_onItemToggleCompleted);
  }

  void _onItemToggleCompleted(
      TodoItemToggleCompletedEvent event, Emitter<TodoUpdateState> emit) async {
    emit(TodoUpdateLoadingState());
    try {
      var todoDomain = TodoEntity(event.todo.id, event.todo.title,
          event.todo.description, !event.todo.isCompleted);
      toggleCompleteTodoUseCase.execute(event.todo);
      emit(const TodoUpdatedState());
      // add(TodoStartedEvent());
    } catch (_) {
      emit(const TodoUpdateErrorState());
    }
  }
}
