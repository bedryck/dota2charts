import 'package:flutter/material.dart';
import 'package:share/share.dart';
import '../../localData/localData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../../store/player.dart';
import '../../store/store.dart';

class AppDrower extends StatefulWidget {
  @override
  _AppDrowerState createState() => _AppDrowerState();
}

class _AppDrowerState extends State<AppDrower> {
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Сonfirm exit"),
          content: Text("This will reset the app to default settings"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Logout"),
              onPressed: () {
                // Navigator.of(context).pop();
                print('logout');
                Provider.of<UserModel>(context, listen: false).setId('');
                setUserId('');
                Provider.of<PlayerModel>(context, listen: false)
                    .setHeroesValue(null);
                Provider.of<PlayerModel>(context, listen: false)
                    .setGamesValue(null);

                Provider.of<PlayerModel>(context, listen: false).setValue(null);
                Provider.of<PlayerModel>(context, listen: false)
                    .setTotalsValue(null);
                Provider.of<PlayerModel>(context, listen: false)
                    .setCountsValue(null);

                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/notAuth', (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  _launchURL() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.dota_2_charts';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = Provider.of<PlayerModel>(context, listen: true).profileName;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Settings',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.rate_review,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Rate app',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            onTap: () {
              _launchURL();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Share',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            onTap: () {
              Share.share(
                  'https://play.google.com/store/apps/details?id=com.dota_2_charts');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            onTap: () {
              _showDialog();
            },
          ),
        ],
      ),
    );
  }
}
