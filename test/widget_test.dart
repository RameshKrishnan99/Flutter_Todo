// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/presentation/bloc/add/add_bloc.dart';
import 'package:flutter_todo/presentation/bloc/delete/delete_bloc.dart';
import 'package:flutter_todo/presentation/bloc/todo_bloc.dart';
import 'package:flutter_todo/presentation/bloc/todo_event.dart';
import 'package:flutter_todo/presentation/bloc/todo_state.dart';
import 'package:flutter_todo/presentation/bloc/update/update_bloc.dart';
import 'package:flutter_todo/presentation/model/todo_model.dart';
import 'package:flutter_todo/presentation/page/home/home_screen.dart';
import 'package:flutter_todo/domain/entity/todo_domain.dart';
import 'package:flutter_todo/domain/usecase/add_todo_usecase.dart';
import 'package:flutter_todo/domain/usecase/delete_todo_usecase.dart';
import 'package:flutter_todo/domain/usecase/get_all_todo_usecase.dart';
import 'package:flutter_todo/domain/usecase/get_selected_todo_usecase.dart';
import 'package:flutter_todo/domain/usecase/toggle_complete_todo_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'di/dependency_injection.dart';
import 'helper/pump_app.dart';
import 'mock/fake_todo_domain.dart';
import 'mock/mock_add_todo_usecase.dart';
import 'mock/mock_delete_todo_usecase.dart';
import 'mock/mock_get_all_todo_usecase.dart';
import 'mock/mock_get_selected_todo_usecase.dart';
import 'mock/mock_toggle_complete_todo_usecase.dart';

void main() {
  var mockTodoDomain1 = TodoEntity(1, "test1", "description1", false);
  var mockTodoDomain2 = TodoEntity(2, "test2", "description2", false);
  var mockTodoVO1 = TodoEntity(mockTodoDomain1.id, mockTodoDomain1.title,
      mockTodoDomain1.description, mockTodoDomain1.isCompleted);
  var mockTodoVO2 = TodoEntity(mockTodoDomain2.id, mockTodoDomain2.title,
      mockTodoDomain2.description, mockTodoDomain2.isCompleted);

  final mockTodoDomainList = [
    mockTodoDomain1,
    mockTodoDomain2,
  ];
  var todoVOToAdd1 = TodoEntity(
       3,
       "new test1",
       "new description1",
       false);

  var todoVOToAdd2 = TodoEntity(
       4,
       "new test2",
       "new description2",
       false);

  var todoVOToUpdate = TodoEntity(
      4,
      "updated test",
      "updated description",
      false);

  late GetAllTodoUseCase getAllTodoUseCase;
  late GetSelectedTodoUseCase getSelectedTodoUseCase;
  late AddTodoUseCase addTodoUseCase;
  late ToggleCompleteTodoUseCase toggleCompleteTodoUseCase;
  late DeleteTodoUseCase deleteTodoUseCase;

  setUp(() {
    getAllTodoUseCase = MockGetAllTodoUseCase();
    getSelectedTodoUseCase = MockGetSelectedTodoUseCase();
    addTodoUseCase = MockAddTodoUseCase();
    toggleCompleteTodoUseCase = MockToggleCompleteTodoUseCase();
    deleteTodoUseCase = MockDeleteTodoUseCase();
    when(getAllTodoUseCase.execute)
        .thenAnswer((_) => Future.value(mockTodoDomainList));
  });

  setUpAll(() {
    registerFallbackValue(FakeTodoDomain());
  });

  TodoBloc buildTodoBloc() {
    return TodoBloc(
        getAllTodoUseCase: getAllTodoUseCase,
        getSelectedTodoUseCase: getSelectedTodoUseCase);
  }

  AddBloc buildTodoAddBloc() {
    return AddBloc(addTodoUseCase: addTodoUseCase);
  }

  DeleteBloc buildTodoDeleteBloc() {
    return DeleteBloc(
      deleteTodoUseCase: deleteTodoUseCase,
    );
  }

  UpdateBloc buildTodoUpdateBloc() {
    return UpdateBloc(
      toggleCompleteTodoUseCase: toggleCompleteTodoUseCase,
    );
  }

  group('TodoListScreen', () {
    late TodoBloc todoBloc;
    late AddBloc addBloc;
    late DeleteBloc deleteBloc;
    late UpdateBloc updateBloc;

    setUp(() {
      todoBloc = provideTodoBloc();
      addBloc = provideAddBloc();
      deleteBloc = provideDeleteBloc();
      updateBloc = provideUpdateBloc();
    });

    tearDown(() => {
          todoBloc.close(),
          addBloc.close(),
          deleteBloc.close(),
          updateBloc.close()
        });

    const addTitleTextFormField = Key('addTodo_title_textFormField');
    const addDescriptionTextFormField =
        Key('addTodo_description_textFormField');
    const updateTitleTextFormField = Key('updateTodo_title_textFormField');
    const updateDescriptionTextFormField =
        Key('updateTodo_description_textFormField');

    Future<void> startApp(tester) async {
      final todoBloc = provideTodoBloc();
      await tester.pumpApp(
          todoBloc: todoBloc..add(TodoStartedEvent()),
          child: MaterialApp(
            home: HomeScreen(),
          ));
      await tester.pumpAndSettle();
    }

    testWidgets('should display todo items', (tester) async {
      final bloc = buildTodoBloc();
      final deleteBloc = buildTodoDeleteBloc();
      final updateBloc = buildTodoUpdateBloc();
      await tester.pumpApp(
          todoBloc: bloc,
          deleteBloc: deleteBloc,
          updateBloc: updateBloc,
          child: MaterialApp(
            home: HomeScreen(),
          ));
      await tester.pumpAndSettle();

      expect(find.text('${Status.All.name} Todo'), findsOneWidget);
      expect(find.text('Empty'), findsNothing);
      expect(find.text(mockTodoDomain1.title), findsOneWidget);
      expect(find.text(mockTodoDomain1.description), findsOneWidget);
      expect(find.text(mockTodoDomain2.title), findsOneWidget);
      expect(find.text(mockTodoDomain2.description), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      verify(getAllTodoUseCase.execute).called(1);
    });

    testWidgets('should work curd process properly', (tester) async {
      final todoBloc = provideTodoBloc();
      final addBloc = provideAddBloc();
      final deleteBloc = provideDeleteBloc();
      final updateBloc = provideUpdateBloc();
      await tester.pumpApp(
          todoBloc: todoBloc,
          addBloc: addBloc,
          deleteBloc: deleteBloc,
          updateBloc: updateBloc,
          child: MaterialApp(
            home: HomeScreen(),
          ));
      await tester.pumpAndSettle();

      //region R- Read
      expect(find.text('${Status.All.name} Todo'), findsOneWidget);
      expect(find.text('Empty'), findsOneWidget);
      //endregion

      //region C- Create
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      //Check Add Todo views
      expect(find.text('Add Todo'), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);

      // Add first todo
      await tester.enterText(
          find.byKey(addTitleTextFormField), todoVOToAdd1.title);
      await tester.enterText(
          find.byKey(addDescriptionTextFormField), todoVOToAdd1.description);

      // Tap the "Add" button
      final addButton = find.text('Add');
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Verify that the new
      final newTodoItemTitle = find.text(todoVOToAdd1.title);
      final newTodoItemDescription = find.text(todoVOToAdd1.description);
      expect(newTodoItemTitle, findsOneWidget);
      expect(newTodoItemDescription, findsOneWidget);
      final firstCheckbox = tester
          .widget<Checkbox>(find.byKey(const Key('todo_item_checkbox_1')));
      expect(firstCheckbox.value, isFalse);
      expect(find.text('Add Todo'), findsNothing);
      expect(find.text('Empty'), findsNothing);
      expect(find.text('${Status.All.name} Todo'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Add second todo
      // Find the input fields and enter some text
      await tester.enterText(
          find.byKey(addTitleTextFormField), todoVOToAdd2.title);
      await tester.enterText(
          find.byKey(addDescriptionTextFormField), todoVOToAdd2.description);

      // Tap the "Add" button
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Verify that the new
      expect(find.text(todoVOToAdd2.title), findsOneWidget);
      expect(find.text(todoVOToAdd2.description), findsOneWidget);
      var secondCheckbox = tester
          .widget<Checkbox>(find.byKey(const Key('todo_item_checkbox_2')));
      expect(secondCheckbox.value, isFalse);
      expect(find.text('Add Todo'), findsNothing);
      expect(find.text('Empty'), findsNothing);
      expect(find.text('${Status.All.name} Todo'), findsOneWidget);
      //endregion

      //Check toggle checkbox
      await tester.tap(find.byKey(const Key('todo_item_checkbox_2')));
      await tester.pump();

      secondCheckbox = tester
          .widget<Checkbox>(find.byKey(const Key('todo_item_checkbox_2')));
      expect(secondCheckbox.value, isTrue);

      //endregion

      //region D-Delete
      var latestTodoList = [];
      if (todoBloc.state is TodoLoadedState) {
        if (todoBloc.state.props.first is TodoModel) {
          latestTodoList = (todoBloc.state.props.first as TodoModel).todoList;
        }
      }
      var lastTodoList = await tester.fling(
        find.text(todoVOToAdd1.title),
        const Offset(-300, 0),
        3000,
      );
      await tester.pumpAndSettle();

      // Verify that the last one is deleted
      expect(find.text(todoVOToAdd1.title), findsNothing);
      expect(find.text(todoVOToAdd1.description), findsNothing);
    });
  });
}
