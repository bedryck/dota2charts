import 'package:flutter/material.dart';
import '../../store/them.dart';
import 'package:provider/provider.dart';
import '../../localData/localData.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<bool> isSelected;

  @override
  void initState() {
    bool them = Provider.of<ThemModel>(context, listen: false).isLightTheme;

    isSelected = [
      them,
      !them,
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Text(
                  'Mode: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ToggleButtons(
                  children: <Widget>[
                    Icon(Icons.wb_sunny),
                    Icon(Icons.brightness_3),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected[buttonIndex] = true;
                          if (index == 0) {
                            Provider.of<ThemModel>(context, listen: false)
                                .setThemeData(true);
                            setThem('light');
                          } else {
                            Provider.of<ThemModel>(context, listen: false)
                                .setThemeData(false);
                            setThem('dark');
                          }
                        } else {
                          isSelected[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  isSelected: isSelected,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
