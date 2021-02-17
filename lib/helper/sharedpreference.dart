import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferencesUserLoggedInKey = 'ISLOGGEDIN';
  static String sharedPreferencesUserNameKey = 'USERNAMEKEY';
  static String sharedPreferencesUserEmailKey = 'USEREMAILKEY';

  ///Saving Data
  static Future<void> saveUserLoggedInPreferences(bool isLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferencesUserLoggedInKey, isLoggedIn);
  }

  static Future<void> saveUserNamePreferences(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferencesUserNameKey, userName);
  }

  static Future<void> saveUserEmailPreferences(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        sharedPreferencesUserEmailKey, userEmail);
  }

  ///getting Data
  static Future<bool> getUserLoggedInPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferencesUserLoggedInKey);
  }

  static Future<String> getUserNamePreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferencesUserNameKey);
  }

  static Future<String> getUserEmailPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferencesUserEmailKey);
  }
}
