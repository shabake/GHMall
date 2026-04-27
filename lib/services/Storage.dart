import 'package:shared_preferences/shared_preferences.dart';

class Storage{

  static Future<void> setString(String key, String value) async{
       SharedPreferences sp=await SharedPreferences.getInstance();
       sp.setString(key, value);
  }
  static Future<String?> getString(String key) async{
       SharedPreferences sp=await SharedPreferences.getInstance();
       return sp.getString(key);
  }
  static Future<void> remove(String key) async{
       SharedPreferences sp=await SharedPreferences.getInstance();
       sp.remove(key);
  }
  static Future<void> clear() async{
       SharedPreferences sp=await SharedPreferences.getInstance();
       sp.clear();
  }

}