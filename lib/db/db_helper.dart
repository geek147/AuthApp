import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../model/user.dart';

class DbHelper {
  static Database? _db;

  static const String dbName = 'test.db';
  static const String tableUser = 'user';
  static const int version = 1;

  static const String userIdColumn = 'user_id';
  static const String userNameColumn = 'user_name';
  static const String emailColumn = 'email';
  static const String passwordColumn = 'password';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $tableUser ("
        " $userIdColumn TEXT, "
        " $userNameColumn TEXT, "
        " $emailColumn TEXT,"
        " $passwordColumn TEXT, "
        " PRIMARY KEY ($userIdColumn)"
        ")");
  }

  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient?.insert(tableUser, user.toMap());
    return res ?? 0;
  }

  Future<UserModel?> getLoginUser(String userName, String password) async {
    var dbClient = await db;
    var res = await dbClient?.rawQuery("SELECT * FROM $tableUser WHERE "
        "$userNameColumn = '$userName' AND "
        "$passwordColumn = '$password'");

    if (res != null) {
      if (res.isNotEmpty) {
        return UserModel.fromMap(res.first);
      }
    }

    return null;
  }
}
