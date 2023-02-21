// ignore: file_names
import 'package:shared_preferences/shared_preferences.dart';

class MemoryManagement {
  static SharedPreferences? pref;
  static const String isLoggedIn = 'logged-in-status';

  static Future init() async {
    pref = await SharedPreferences.getInstance();
  }

  static void setLoggedIn(bool value) {
    pref!.setBool(isLoggedIn, value);
  }

  static bool? getLoggedIn() {
    return pref!.getBool(isLoggedIn);
  }
}
