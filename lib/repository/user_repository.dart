import 'package:notebook/databasehelper/databaseHelper.dart';
import 'package:notebook/models/user.dart';

class UserRepository {
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<int> saveUser(User user) async {
    return dbHelper.userRegistration(user);
  }

  Future<List<User>> fetchUser(String userName, String password) {
    return dbHelper.fetchUserList(userName, password);
  }

  Future<bool> isUserExist(String email) async {
    return dbHelper.isExist(email);
  }
}
