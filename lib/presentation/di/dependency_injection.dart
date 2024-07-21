import 'package:flutter_todo/presentation/bloc/add/add_bloc.dart';
import 'package:flutter_todo/presentation/bloc/delete/delete_bloc.dart';
import 'package:flutter_todo/presentation/bloc/todo_bloc.dart';
import 'package:flutter_todo/presentation/bloc/update/update_bloc.dart';
import 'package:flutter_todo/data/repository_impl/todo_repository_impl.dart';
import 'package:flutter_todo/domain/repository/todo_repository.dart';
import 'package:flutter_todo/domain/usecase/get_selected_todo_usecase.dart';
import 'package:get_it/get_it.dart';

import '../../data/datasource/crud_datasource.dart';
import '../../domain/usecase/add_todo_usecase.dart';
import '../../domain/usecase/delete_todo_usecase.dart';
import '../../domain/usecase/get_all_todo_usecase.dart';
import '../../domain/usecase/toggle_complete_todo_usecase.dart';

GetIt getIt = GetIt.instance;

Future configureDependencies(CRUDDataSource dataSource) async {
  //datasource
  getIt.registerLazySingleton<CRUDDataSource>(() => dataSource);

  //repository
  getIt.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(getIt()));

  //use case
  getIt.registerLazySingleton<GetAllTodoUseCase>(() => GetAllTodoUseCase(getIt()));
  getIt.registerLazySingleton<GetSelectedTodoUseCase>(() => GetSelectedTodoUseCase(getIt()));
  getIt.registerLazySingleton<AddTodoUseCase>(() => AddTodoUseCase(getIt()));
  getIt.registerLazySingleton<ToggleCompleteTodoUseCase>(() => ToggleCompleteTodoUseCase(getIt()));
  getIt.registerLazySingleton<DeleteTodoUseCase>(() => DeleteTodoUseCase(getIt()));

  //bloc
  getIt.registerFactory<TodoBloc>(() => TodoBloc(getAllTodoUseCase: getIt(),getSelectedTodoUseCase: getIt()));
  getIt.registerFactory<AddBloc>(() => AddBloc(addTodoUseCase: getIt()));
  getIt.registerFactory<DeleteBloc>(() => DeleteBloc(deleteTodoUseCase: getIt()));
  getIt.registerFactory<UpdateBloc>(() => UpdateBloc(toggleCompleteTodoUseCase: getIt()));

}