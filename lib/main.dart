import 'package:flutter/material.dart';
import './navigation/routes.dart';
import './store/store.dart';
import 'package:provider/provider.dart';
import './store/player.dart';
import './store/appSettings.dart';
import './store/them.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserModel>(create: (_) => UserModel()),
          ChangeNotifierProvider<PlayerModel>(create: (_) => PlayerModel()),
          ChangeNotifierProvider<AppSettingsModel>(
              create: (_) => AppSettingsModel()),
          ChangeNotifierProvider<ThemModel>(
              create: (_) => ThemModel()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemModel>(context);
    return MaterialApp(
      theme: themeProvider.getThemeData,
      initialRoute: '/',
      routes: routes,
    );
  }
}
