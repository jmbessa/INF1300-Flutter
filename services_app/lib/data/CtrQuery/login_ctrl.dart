import '../../models/user.dart';
import 'dart:async';
import '../../database/database_connection.dart';

class LoginCtr {
  WorkersDatabase con = new WorkersDatabase();

//insertion
  Future<int> saveUser(User user) async {
    var dbClient = await con.database;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await con.database;
    int res = await dbClient.delete("User");
    return res;
  }

  Future<User?> getLogin(String user, String password) async {
    var dbClient = await con.database;
    var res = await dbClient.rawQuery(
        "SELECT * FROM user WHERE username = '$user' and password = '$password'");

    if (res.length > 0) {
      return new User.fromMap(res.first);
    }

    return null;
  }

  Future<List<User>?> getAllUser() async {
    var dbClient = await con.database;
    var res = await dbClient.query("user");

    List<User>? list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : null;

    return list;
  }
}
