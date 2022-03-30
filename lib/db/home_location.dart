import 'package:flutter/cupertino.dart';
import 'package:map/models/location.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HomeLocation extends ChangeNotifier {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'example.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, lat REAL, lon REAL)',
        );
      },
      version: 1,
    );
  }

  Future<int> insertLocation(int id, double lat, double lon) async {
    int result = 0;
    final Database db = await initializeDB();
    result =
        await db.insert('users', Location(id: id, lat: lat, lon: lon).toMap());

    notifyListeners();
    return result;
  }

  Future<List<Location>> retrieveLocation() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('users');

    var a = queryResult.map((e) => Location.fromMap(e)).toList();
    return a;
  }

  Future<int> updateItem(int id, double lat, double lon) async {
    final Database db = await initializeDB();

    final data = {'lat': lat, 'lon': lon};

    final result =
        await db.update('users', data, where: "id = ?", whereArgs: [id]);

    notifyListeners();
    return result;
  }

  Future<void> deleteLocation(int id) async {
    final db = await initializeDB();
    await db.delete(
      'users',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAllLocation() async {
    final db = await initializeDB();
    await db.delete('users');
    notifyListeners();
  }
}
