class Util {
  static String greeting() {
    int hour = DateTime.now().hour;
    String meassage = "";
    if (hour >= 0 && hour < 6) {
      meassage = "Good Night";
    } else if (hour >= 0 && hour < 12) {
      meassage = "Good Morning";
    } else if (hour >= 12 && hour < 16) {
      meassage = "Good Afternoon";
    } else if (hour >= 16 && hour < 21) {
      meassage = "Good Evening";
    } else if (hour >= 21 && hour < 24) {
      meassage = "Good Night";
    }
    return meassage;
  }

  static bool isEmailFormatNotValid(String? email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(pattern);
    if (email != null) {
      if (!regExp.hasMatch(email)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }


}
