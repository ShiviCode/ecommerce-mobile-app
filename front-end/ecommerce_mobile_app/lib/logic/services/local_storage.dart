import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveUserDetails(String email, String password) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString("email", email);
    await instance.setString("password", password);
  }

  static Future<Map<String, dynamic>> fetchUserDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? email = instance.getString("email");
    String? password = instance.getString("password");
    return {
      "email": email,
      "password": password,
    };
  }

  static Future<void> deleteUserDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    // await instance.remove("email");
    // await instance.remove("password");
    await instance.clear();
  }
}
