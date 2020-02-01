import 'package:flutter/material.dart';

  ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.dark,
    accentColor: Colors.blueGrey,
  );

  ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
  );

class ThemModel extends ChangeNotifier {
  bool isLightTheme;
  ThemModel({this.isLightTheme = false});


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
