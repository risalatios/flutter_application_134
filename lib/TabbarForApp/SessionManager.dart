
import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  
   static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
   }

   static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

   static Future<void> isLoginSave(String isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('isLogin', isLogin);
   }

    static Future<String?> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('isLogin');
  }


}
