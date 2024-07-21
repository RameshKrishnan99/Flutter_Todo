import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/presentation/bloc/add/add_bloc.dart';
import 'package:flutter_todo/presentation/bloc/delete/delete_bloc.dart';
import 'package:flutter_todo/presentation/bloc/todo_bloc.dart';
import 'package:flutter_todo/presentation/bloc/todo_event.dart';
import 'package:flutter_todo/presentation/bloc/todo_state.dart';
import 'package:flutter_todo/presentation/bloc/update/update_bloc.dart';
import 'package:flutter_todo/presentation/routing/go_router.dart';
import 'package:flutter_test/flutter_test.dart';

class MockTodoBloc extends MockBloc<TodoEvent, TodoState> implements TodoBloc {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    TodoBloc? todoBloc,
    AddBloc? addBloc,
    DeleteBloc? deleteBloc,
    UpdateBloc? updateBloc,
    required Widget child,
  }) {

    return pumpWidget(MultiBlocProvider(
        providers: [
          if (todoBloc != null)
            BlocProvider(create: (_) => todoBloc..add(TodoStartedEvent()))
          else
            BlocProvider(
                create: (_) =>
                MockTodoBloc()
                  ..add(TodoStartedEvent())),

          if(addBloc != null)
            BlocProvider(create: (_) => addBloc),

          if(deleteBloc != null)
            BlocProvider(create: (_) => deleteBloc),

          if(updateBloc != null)
            BlocProvider(create: (_) => updateBloc)
        ],
        child: MaterialApp.router(
          title: 'Todo',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
        )));
  }
}
