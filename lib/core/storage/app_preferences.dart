// app_preferences.dart

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
  static const String _keyUserId = 'userId';
    static const String _keySavedJobs = 'savedJobs';




  static const String _keySearchHistory = 'searchHistory';

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

// 🔹 Save user's ID (for authenticated requests)
Future<void> setUserId(int id) async {
  await _prefs.setInt(_keyUserId, id);
}

int? getUserId() {
  return _prefs.getInt(_keyUserId);
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

  // ------------- Search History --------------------

  Future<void> addSearchQuery(String query) async {
    if(query.trim().isEmpty) return;
    final history = _prefs.getStringList(_keySearchHistory) ?? [];
    // Remove duplicates
    history.removeWhere((element) => element.toLowerCase() == query.toLowerCase());
    // Add to front
    history.insert(0, query);
    // Limit to 10 entries max
    if (history.length > 10) {
      history.removeLast();
    }
    await _prefs.setStringList(_keySearchHistory, history);
  }

  List<String> getSearchHistory() {
    return _prefs.getStringList(_keySearchHistory) ?? [];
  }

  Future<void> clearSearchHistory() async {
    await _prefs.remove(_keySearchHistory);
  }

  // 🔹 Saved Jobs Helpers
  List<String> getSavedJobsRaw() {
  return _prefs.getStringList(_keySavedJobs) ?? [];
}

Future<void> setSavedJobsRaw(List<String> jobs) async {
  await _prefs.setStringList(_keySavedJobs, jobs);
}

Future<void> clearSavedJobs() async {
  await _prefs.remove(_keySavedJobs);
}

}
