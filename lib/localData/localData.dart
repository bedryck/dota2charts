import 'package:shared_preferences/shared_preferences.dart';

Future<String> getUserId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId') ?? '';
}

Future<bool> setUserId(value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('userId', value);
}

Future<bool> removeUserId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove('userId');
}

Future<String> getThem() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('them') ?? '';
}

Future<bool> setThem(value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('them', value);
}

Future<bool> removeThem() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove('them');
}
