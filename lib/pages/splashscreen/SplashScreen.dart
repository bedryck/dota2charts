import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:provider/provider.dart';
import '../../localData/localData.dart';
import '../../store/store.dart';
import '../../actions/getAppSettings.dart';
import '../../store/appSettings.dart';
import '../../store/them.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  String userID;
  String them;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    try {
      bool isLight = true;
      this.userID = await getUserId();
      this.them = await getThem();
      if (them == 'dark') {
        isLight = false;
      }

      Provider.of<UserModel>(context, listen: false).setId(userID);
      Provider.of<ThemModel>(context, listen: false).setThemeData(isLight);

      final responseAppSettings = getAppSettings();
      final patchAppSettings = getPatchAppSettings();

      Provider.of<AppSettingsModel>(context, listen: false)
          .setValue(await responseAppSettings);
      Provider.of<AppSettingsModel>(context, listen: false)
          .setPatchValue(await patchAppSettings);
      return Timer(Duration(milliseconds: 1500), onDoneLoading);
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error: ${e.toString()}'),
        duration: Duration(seconds: 5),
      ));
      return Timer(Duration(seconds: 0), () {});
    }
  }

  onDoneLoading() {
    print('splash screen');

    print(this.userID);
    if (this.userID != '') {
      print('change to home with id ${this.userID}');
      Navigator.pushReplacementNamed(context, '/profile');
    } else {
      Navigator.pushReplacementNamed(context, '/notAuth');
      print('change to login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          color: Colors.white,
          child: Center(
              child: Container(
            width: 200,
            height: 200,
            child: FlareActor("animation/dotacharts.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "splash"),
          )),
        ));
  }
}
