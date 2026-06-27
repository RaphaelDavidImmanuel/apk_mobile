import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String emailKey = "email";
  static const String passwordKey = "password";

  Future<void> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(emailKey, email);
    await prefs.setString(passwordKey, password);
  }

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    String? savedEmail = prefs.getString(emailKey);
    String? savedPassword = prefs.getString(passwordKey);

    return email == savedEmail && password == savedPassword;
  }

  Future<void> logout() async {
    // tidak melakukan apa-apa
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(emailKey);
  }
}
