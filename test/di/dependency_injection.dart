import 'package:flutter_todo/presentation/bloc/add/add_bloc.dart';
import 'package:flutter_todo/presentation/bloc/delete/delete_bloc.dart';
import 'package:flutter_todo/presentation/bloc/todo_bloc.dart';
import 'package:flutter_todo/presentation/bloc/update/update_bloc.dart';
import 'package:flutter_todo/data/datasource/crud_datasource.dart';
import 'package:flutter_todo/data/repository_impl/todo_repository_impl.dart';
import 'package:flutter_todo/domain/repository/todo_repository.dart';
import 'package:flutter_todo/domain/usecase/add_todo_usecase.dart';
import 'package:flutter_todo/domain/usecase/delete_todo_usecase.dart';
import 'package:flutter_todo/domain/usecase/get_all_todo_usecase.dart';
import 'package:flutter_todo/domain/usecase/get_selected_todo_usecase.dart';
import 'package:flutter_todo/domain/usecase/toggle_complete_todo_usecase.dart';
import '../mock/mock_database.dart';

//datasource
CRUDDataSource provideCRUDDataSource() => MockDatabase();

//repository
TodoRepository provideTodoRepository() =>
    TodoRepositoryImpl(provideCRUDDataSource());

//use case
GetAllTodoUseCase provideGetAllTodoUseCase() =>
    GetAllTodoUseCase(provideTodoRepository());

GetSelectedTodoUseCase provideGetSelectedTodoUseCase() =>
    GetSelectedTodoUseCase(provideTodoRepository());

AddTodoUseCase provideAddTodoUseCase() =>
    AddTodoUseCase(provideTodoRepository());

ToggleCompleteTodoUseCase provideToggleCompleteTodoUseCase() =>
    ToggleCompleteTodoUseCase(provideTodoRepository());
DeleteTodoUseCase provideDeleteTodoUseCase() =>
    DeleteTodoUseCase(provideTodoRepository());


//bloc
TodoBloc provideTodoBloc() => TodoBloc(
    getAllTodoUseCase: provideGetAllTodoUseCase(),
    getSelectedTodoUseCase: provideGetSelectedTodoUseCase());

AddBloc provideAddBloc() => AddBloc(addTodoUseCase: provideAddTodoUseCase(),);
DeleteBloc provideDeleteBloc() => DeleteBloc(deleteTodoUseCase: provideDeleteTodoUseCase());
UpdateBloc provideUpdateBloc() => UpdateBloc(toggleCompleteTodoUseCase: provideToggleCompleteTodoUseCase());
