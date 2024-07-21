import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/presentation/bloc/delete/todo_delete_state.dart';
import 'package:flutter_todo/presentation/bloc/todo_event.dart';

import '../../../domain/usecase/delete_todo_usecase.dart';

class DeleteBloc extends Bloc<TodoEvent, TodoDeleteState> {
  final DeleteTodoUseCase deleteTodoUseCase;

  DeleteBloc({required this.deleteTodoUseCase})
      : super(TodoDeleteLoadingState()) {
    on<TodoItemDeletedEvent>(_onItemDeleted);
  }

  void _onItemDeleted(TodoItemDeletedEvent event, Emitter<TodoDeleteState> emit) async {
    emit(TodoDeleteLoadingState());
    try {
      deleteTodoUseCase.execute(event.id);
      // add(TodoStartedEvent());
      emit(const TodoDeletedState());
    } catch (_) {
      emit(const TodoDeleteErrorState());
    }
  }
}
