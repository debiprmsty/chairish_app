import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String PREF_TOKEN = 'token';

  Future<void> setToken(String token)async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_TOKEN, token);
  }

  Future<String?> getToken()async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PREF_TOKEN);
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(PREF_TOKEN);
  }

}