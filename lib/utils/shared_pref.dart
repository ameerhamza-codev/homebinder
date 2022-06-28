import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper{

  Future<void> setPrefUserData(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("USER_DATA", user);
  }

  Future<String> getPrefUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("USER_DATA") ?? "no user";
  }

}