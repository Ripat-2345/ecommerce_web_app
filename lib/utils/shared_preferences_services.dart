import 'package:shared_preferences/shared_preferences.dart';

Future saveToStorage(String key, dynamic data) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, data);
}

Future removeFromStorage(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

Future<String?> readFromStorage(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}
