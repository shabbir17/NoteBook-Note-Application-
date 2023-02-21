import 'package:flutter/cupertino.dart';
import 'package:notebook/models/user.dart';
import 'package:notebook/repository/user_repository.dart';

class UserProvider with ChangeNotifier {
  final UserRepository userRepo = UserRepository();
  bool? _isLoading = false;
  var _user = User();

  User getUser() {
    return _user;
  }

  // get user => _user;
  set user(value) {
    _user = value;
    notifyListeners();
  }

  get isLoading => _isLoading;

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String> saveUser(User user) async {
    String status = "loading";
    isLoading = true;
    int isAdded = await userRepo.saveUser(user);
    if (isAdded > 0) {
      status = "Success";
    } else {
      status = "Error";
    }
    isLoading = false;
    return status;
  }

  Future<void> fetchUser(String userName, String password) async {
    isLoading = true;
    List<User> userList = await userRepo.fetchUser(userName, password);
    if (userList.isNotEmpty) {
      user = userList.first;
    }
    isLoading = false;
  }

  Future<String> isUserExist(User user) async {
    String status = 'loading';
    isLoading = true;
    bool isExist = await userRepo.isUserExist(user.username!);
    if (isExist == false) {
      status = await saveUser(user);
    }
    isLoading = false;
    return status;
  }
}
