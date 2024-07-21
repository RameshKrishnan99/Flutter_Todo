import 'package:bloc/bloc.dart';
import 'package:flutter_todo/domain/usecase/get_selected_todo_usecase.dart';
import 'package:flutter_todo/presentation/bloc/todo_event.dart';
import 'package:flutter_todo/presentation/bloc/todo_state.dart';
import 'package:flutter_todo/presentation/model/todo_model.dart';

import '../../domain/usecase/get_all_todo_usecase.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetAllTodoUseCase getAllTodoUseCase;
  final GetSelectedTodoUseCase getSelectedTodoUseCase;

  TodoBloc(
      {required this.getAllTodoUseCase,
      required this.getSelectedTodoUseCase,
      })
      : super(TodoLoadingState()) {
    on<TodoStartedEvent>(_onStarted);
    on<TodoFilterEvent>(_onItemFilter);
  }

  void _onStarted(TodoStartedEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      var dataList = await getAllTodoUseCase.execute();

      emit(TodoLoadedState(TodoModel(todoList:dataList)));
    } catch (e) {
      emit(const TodoErrorState());
    }
  }

  void _onItemFilter(TodoFilterEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      var dataList = await getSelectedTodoUseCase.execute(event.value);
      emit(TodoLoadedState(TodoModel(todoList:dataList)));
    } catch (e) {
      emit(const TodoErrorState());
    }
  }





}
