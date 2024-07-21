import 'package:floor/floor.dart';
import 'dart:async';
import 'dao/todo_dao.dart';
import '../model/todo.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart';

@Database(version: 1,entities: [TodoModel])
abstract class AppDatabase extends FloorDatabase {
  TodoDao get todoDao;
}
