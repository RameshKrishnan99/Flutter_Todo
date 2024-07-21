import 'package:flutter/material.dart';
import 'package:flutter_todo/presentation/bloc/add/add_bloc.dart';
import 'package:flutter_todo/presentation/bloc/delete/delete_bloc.dart';
import 'package:flutter_todo/presentation/bloc/update/update_bloc.dart';

import 'presentation/bloc/todo_bloc.dart';
import 'presentation/di/dependency_injection.dart';
import 'presentation/bloc/todo_event.dart';
import 'presentation/routing/go_router.dart';
import 'data/database/app_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasource/crud_datasource.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppDatabase appDatabase = await $FloorAppDatabase.databaseBuilder('flutter_todo.db').build();
  CRUDDataSource dataSource = CRUDDataSource();
  await dataSource.initialize(appDatabase);
  configureDependencies(dataSource);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TodoBloc todoBloc = getIt<TodoBloc>();
  final AddBloc addBloc = getIt<AddBloc>();


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => todoBloc..add(TodoStartedEvent()),
          ), BlocProvider(
            create: (_) => addBloc,
          ),BlocProvider(
            create: (_) => getIt<DeleteBloc>(),
          ),BlocProvider(
            create: (_) => getIt<UpdateBloc>(),
          ),
        ],
        child: MaterialApp.router(
          title: 'CGI Todo',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
        ));
  }
}

