import 'package:flutter/material.dart';
import './navigation/routes.dart';
import './store/store.dart';
import 'package:provider/provider.dart';
import './store/player.dart';
import './store/appSettings.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          // ChangeNotifierProvider(create: (context) => UserModel()),
          ChangeNotifierProvider<UserModel>(create: (_) => UserModel()),
          ChangeNotifierProvider<PlayerModel>(create: (_) => PlayerModel()),
          ChangeNotifierProvider<AppSettingsModel>(create: (_) => AppSettingsModel()),
        ],
        child: MyApp(),
      ),
    );



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //  brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: routes,
    );
  }
}