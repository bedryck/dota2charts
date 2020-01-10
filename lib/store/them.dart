import 'package:flutter/material.dart';

class ThemModel extends ChangeNotifier {
  ThemModel({this.isLightTheme});
  bool isLightTheme;

  final darkTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.dark,
    accentColor: Colors.blueGrey,
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
  );
  bool get getThem => isLightTheme;

  ThemeData get getThemeData => isLightTheme ? lightTheme : darkTheme;

  void setThemeData(bool val) {
    if (val) {
      isLightTheme = true;
    } else {
      isLightTheme = false;
    }
    notifyListeners();
  }
}
