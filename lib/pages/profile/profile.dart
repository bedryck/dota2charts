import 'package:flutter/material.dart';
import '../../actions/getPlayer.dart';
import 'package:provider/provider.dart';
import '../../store/player.dart';
import './profileAppBar.dart';
import './mainInform.dart';
import './listInformContainer.dart';
// import '../../store/appSettings.dart';
// import '../../actions/getAppSettings.dart';
import '../../store/store.dart';

import './drower.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool animation = true;
  bool isError = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final String userId =
          Provider.of<UserModel>(context, listen: false).currentId;
      // final responseAppSettings = getAppSettings();
      // final patchAppSettings = getPatchAppSettings();

      final response = getPlayer(userId);
      final responseTotals = getPlayerTotals(userId);
      final responseCounts = getPlayerCounts(userId);
      final responseHeroes = getPlayerHeroes(userId);
      final responseMatches = getPlayerRecentMatches(userId);

      // Provider.of<AppSettingsModel>(context, listen: false)
      //     .setValue(await responseAppSettings);
      // Provider.of<AppSettingsModel>(context, listen: false)
      //     .setPatchValue(await patchAppSettings);

      Provider.of<PlayerModel>(context, listen: false)
          .setHeroesValue(await responseHeroes);
      Provider.of<PlayerModel>(context, listen: false)
          .setGamesValue(await responseMatches);

      Provider.of<PlayerModel>(context, listen: false).setValue(await response);
      Provider.of<PlayerModel>(context, listen: false)
          .setTotalsValue(await responseTotals);
      Provider.of<PlayerModel>(context, listen: false)
          .setCountsValue(await responseCounts);

      setState(() {
        animation = false;
        isError = false;
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error: ${e.toString()}'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;


    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrower(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            ProfileAppBar(),
          ];
        },
        body: Consumer<PlayerModel>(builder: (context, player, child) {
          if (isError) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.error,
                    color: Color(0xffD57A66),
                    size: 30.0,
                    semanticLabel: 'Error',
                  ),
                  Text(
                    ' Oops something went wrong... try later',
                    style: TextStyle(color: Color(0xffD57A66)),
                  )
                ],
              ),
            );
          }
          return player.value != null &&
                  player.totalsValue != null &&
                  player.countsValue != null
              ? RefreshIndicator(
                  onRefresh: getData,
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: <Widget>[
                      MainInform(
                          screenSize,
                          player.countsRadiant['win'],
                          player.countsRadiant['games'],
                          player.countsDire['win'],
                          player.countsDire['games'],
                          animation),
                      ListInformContainer()
                    ],
                  ))
              : Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
