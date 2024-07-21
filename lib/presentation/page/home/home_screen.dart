import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/presentation/bloc/delete/delete_bloc.dart';
import 'package:flutter_todo/presentation/bloc/delete/todo_delete_state.dart';
import 'package:flutter_todo/presentation/bloc/update/todo_update_state.dart';
import 'package:flutter_todo/presentation/bloc/update/update_bloc.dart';
import 'package:flutter_todo/domain/entity/todo_domain.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/todo_bloc.dart';
import '../../bloc/todo_event.dart';
import '../../bloc/todo_state.dart';
import '../../helper/app_utils.dart';
import '../../routing/app_route.dart';
import 'component/todo_list_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  String title = Status.All.name;

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.title} Todo'),
          actions: <Widget>[
            PopupMenuButton<int>(
              icon: const Icon(
                Icons.filter_list_alt,
                color: Colors.white,
              ),
              itemBuilder: (context) => [
                // PopupMenuItem 1
                PopupMenuItem(
                  value: Status.All.index,
                  // row with 2 children
                  child: Row(
                    children: [
                      const Icon(Icons.select_all),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(Status.All.name)
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: Status.Pending.index,
                  // row with two children
                  child: Row(
                    children: [
                      const Icon(Icons.incomplete_circle),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(Status.Pending.name)
                    ],
                  ),
                ),
                // PopupMenuItem 2
                PopupMenuItem(
                  value: Status.Completed.index,
                  // row with two children
                  child: Row(
                    children: [
                      const Icon(Icons.done),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(Status.Completed.name)
                    ],
                  ),
                ),
              ],
              offset: Offset(0, 100),
              color: Colors.grey,
              elevation: 2,
              // on selected we show the dialog box
              onSelected: (value) {
                // if value 1 show dialog

                onClickFliter(value);
                setState(() {
                  widget.title = Status.values[value].name;
                });
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push("/${Routes.addScreen}"),
          child: const Icon(Icons.add),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<DeleteBloc, TodoDeleteState>(
                listener: (context, state) {
                  if (state is TodoDeletedState) {
                    context.read<TodoBloc>().add(TodoStartedEvent());
                  }
                }),
          ],
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodoLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is TodoLoadedState) {
                if (state.todoModel.todoList.isEmpty) {
                  return const Center(
                    child: Text('Empty'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: state.todoModel.todoList.length,
                    itemBuilder: (context, index) {
                      var todoVO = state.todoModel.todoList[index];
                      return TodoListItem(
                          todoDomain: todoVO,
                          onClickItem: () => {},
                          onClickDelete: () => {
                                context
                                    .read<DeleteBloc>()
                                    .add(TodoItemDeletedEvent(todoVO.id!)),
                                AppUtils.showSnackBar(
                                  context: context,
                                  message: '${todoVO.title} is deleted',
                                )
                              },
                          onToggleComplete: (value) => {
                            setState(() {
                              todoVO.isCompleted = value ?? false;
                            }),

                                context
                                    .read<UpdateBloc>()
                                    .add(TodoItemToggleCompletedEvent(todoVO))
                              });
                    },
                  );
                }
              }
              return const Text('Something went wrong!');
            },
          ),
        ));
  }

  void onClickFliter(int value) {
    if (value == Status.All.index) {
      context.read<TodoBloc>().add(TodoStartedEvent());
    } else {
      context.read<TodoBloc>().add(TodoFilterEvent(value));
    }
  }
}

enum Status { Pending, Completed, All }
