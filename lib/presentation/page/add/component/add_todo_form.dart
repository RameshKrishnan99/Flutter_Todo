import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/domain/entity/todo_domain.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/add/add_bloc.dart';
import '../../../bloc/add/todo_add_state.dart';
import '../../../bloc/todo_bloc.dart';
import '../../../bloc/todo_event.dart';
import '../../../helper/description_field_validator.dart.dart';
import '../../../helper/title_field_validator.dart';

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({Key? key}) : super(key: key);

  @override
  _AddTodoFormState createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _todoFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddBloc, TodoAddState>(builder: (context, state) {
      if (state is TodoAddedState) {
        context.read<TodoBloc>().add(TodoStartedEvent());
      }
      return Form(
        key: _todoFormKey,
        child: ListView(
          children: [
            const SizedBox(height: 24.0),
            const Text('Title'),
            TextFormField(
              key: const Key('addTodo_title_textFormField'),
              controller: _titleController,
              maxLines: 1,
              maxLength: 50,
              validator: titleFieldValidator,
            ),
            const SizedBox(height: 24.0),
            const Text('Description'),
            TextFormField(
              key: const Key('addTodo_description_textFormField'),
              controller: _descriptionController,
              minLines: 1,
              maxLines: 3,
              maxLength: 200,
              validator: descriptionFieldValidator,
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_todoFormKey.currentState!.validate()) {
                      _addTodo();
                      context.pop();
                    }
                  },
                  child: const Text('Add'),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  _addTodo() async {
    TodoEntity todoVO = TodoEntity(
        0, _titleController.text, _descriptionController.text, false);
    context.read<AddBloc>().add(TodoItemAddedEvent(todoVO));
  }
}
