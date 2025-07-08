import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _keyHasSeenOnboarding = 'hasSeenOnboarding';
  static const String _keyToken = 'token';
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserName = 'userName';
  static const String _keyUserEmail = 'userEmail';
  static const String _keyIsDarkMode = 'isDarkMode';
  static const String _keyLanguage = 'language';
  static const String _keyRememberMe = 'rememberMe';

  final SharedPreferences _prefs;

  AppPreferences(this._prefs);

  // 🔹 Save onboarding status
  Future<void> setOnboardingSeen() async {
    await _prefs.setBool(_keyHasSeenOnboarding, true);
  }

  // 🔹 Check if onboarding was seen
  bool hasSeenOnboarding() {
    return _prefs.getBool(_keyHasSeenOnboarding) ?? false;
  }

  // 🔹 Save auth token after login
  Future<void> setToken(String token) async {
    await _prefs.setString(_keyToken, token);
  }

  // 🔹 Get stored auth token
  String? getToken() {
    return _prefs.getString(_keyToken);
  }

  // 🔹 Save login status
  Future<void> setLoggedIn(bool isLoggedIn) async {
    await _prefs.setBool(_keyIsLoggedIn, isLoggedIn);
  }

  // 🔹 Check login status
  bool isLoggedIn() {
    return _prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // 🔹 Save user's name (optional info)
  Future<void> setUserName(String name) async {
    await _prefs.setString(_keyUserName, name);
  }

  String? getUserName() {
    return _prefs.getString(_keyUserName);
  }

  // 🔹 Save user's email (optional info)
  Future<void> setUserEmail(String email) async {
    await _prefs.setString(_keyUserEmail, email);
  }

  String? getUserEmail() {
    return _prefs.getString(_keyUserEmail);
  }

  // 🔹 Save dark mode preference
  Future<void> setDarkMode(bool isDark) async {
    await _prefs.setBool(_keyIsDarkMode, isDark);
  }

  bool isDarkMode() {
    return _prefs.getBool(_keyIsDarkMode) ?? false;
  }

  // 🔹 Save selected language
  Future<void> setLanguage(String langCode) async {
    await _prefs.setString(_keyLanguage, langCode);
  }

  String getLanguage() {
    return _prefs.getString(_keyLanguage) ?? 'en';
  }

  // 🔹 Remember Me setting
  Future<void> setRememberMe(bool remember) async {
    await _prefs.setBool(_keyRememberMe, remember);
  }

  bool isRemembered() {
    return _prefs.getBool(_keyRememberMe) ?? false;
  }

  // 🔹 Clear all stored preferences (e.g., on logout)
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
