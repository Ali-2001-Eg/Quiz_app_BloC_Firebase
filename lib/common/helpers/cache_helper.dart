import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences sharedPreferences;
  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(
      {required String key, required String value}) async {
    return await sharedPreferences.setString(key, value);
  }

  static String getData(String key) {
     return sharedPreferences.getString(key)??'';
  }
  static Future<bool>clearData(String key)async{
   return await sharedPreferences.remove(key);
  }
}