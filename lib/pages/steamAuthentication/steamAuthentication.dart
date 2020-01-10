import '../../store/store.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import '../../localData/localData.dart';

class SteamAuthentication extends StatefulWidget {
  @override
  _SteamAuthenticationState createState() => _SteamAuthenticationState();
}

class _SteamAuthenticationState extends State<SteamAuthentication> {
  num _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Steam Authentication'),
            ),
            body: IndexedStack(
              index: _stackToView,
              children: [
                Column(
                  children: <Widget>[
                    Expanded(
                        child: WebView(
                      initialUrl: "https://dota-2-charts.herokuapp.com/logout",
                      javascriptMode: JavascriptMode.unrestricted,
                      javascriptChannels: Set.from([
                        JavascriptChannel(
                            name: 'Dotacharts',
                            onMessageReceived: (JavascriptMessage message) {
                              if (message.message != null) {
                                print('message web view ${message.message}');
                                setUserId(
                                    message.message); //set user to local data
                                Provider.of<UserModel>(context, listen: false)
                                    .setId(message.message);

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/profile',
                                    (Route<dynamic> route) => false);
                              }
                            })
                      ]),
                      onWebViewCreated: (WebViewController w) {},
                      onPageFinished: _handleLoad,
                    )),
                  ],
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
