import 'package:app_segpar/TodoList/model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return db;
    }

    _db = await initDataBase();
    return null;
  }

  initDataBase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'Todo.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return db;
  }

  _createDatabase(Database db, int version) async {
    //Crear tabla con datos
    await db.execute(
        'CREATE TABLE mytodo (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NOT NULL, dateandtime TEXTNOT NULL, )');
  }

//Insertar Data
  Future<TodoMOdel> insert(TodoMOdel todoMOdel) async {
    var dbClient = await this.db;
    await dbClient?.insert('mytodo', todoMOdel.toMap());
    return todoMOdel;
  }

  Future<List<TodoMOdel>> getDataList() async {
    await db;
    final List<Map<String, Object?>> QueryResult =
        await _db!.rawQuery('SELECT * FROM Mytodo');
    return QueryResult.map((e) => TodoMOdel.fromMap(e)).toList();
  }

  Future<int> deleteData(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('mytodo', where: 'id =?', whereArgs: [id]);
  }

  Future<int> update(TodoMOdel todoMOdel) async {
    var dbClient = await db;
    return await dbClient!.update('mytodo', todoMOdel.toMap(),
        where: 'id =?', whereArgs: [todoMOdel.id]);
  }
}
