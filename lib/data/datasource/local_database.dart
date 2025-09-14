import 'package:shared_preferences/shared_preferences.dart';


SharedPreferences? prefs;

class LocalDatabase {
  static String isDarkMode = 'darkMode';
  static String hasSeenOnBoarding = 'hasSeenOnboarding';
  static String rememberMe = 'remember_me';
  static String categories = 'categories';
  static String userId = 'user_id';
  static String profileId = 'profile_id';
  static String user = 'user';
  static String email = 'email';
  static String jwt = 'jwt';
  static String request = 'request';
  static String userType = 'user_type';
  static String countryCode = 'countryCode';
  static String sessionToken = 'sessionToken';
}


String getProfileId() {
  return prefs?.getString(LocalDatabase.profileId) ?? '';
}

int getUserId() {
  return prefs?.getInt(LocalDatabase.userId) ?? 0;
}

String getToken() {
  return prefs?.getString(LocalDatabase.jwt) ?? '';
}

String getSessionToken() {
  return prefs?.getString(LocalDatabase.sessionToken) ?? '';
}

String getCountryCode() {
  return prefs?.getString(LocalDatabase.countryCode) ?? 'US';
}


Future<void> clearAllPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

Future<void> clearTwoKeys() async {
  await prefs?.remove(LocalDatabase.jwt);
  await prefs?.remove(LocalDatabase.sessionToken);
}

