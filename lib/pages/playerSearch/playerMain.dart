import 'package:flutter/material.dart';
import 'mainInfo.dart';
import './playerHeroes.dart';
import './LastPlayerGames.dart';
import '../../actions/getPlayer.dart';
import './playerHeroesWinrate.dart';

class PlayerMain extends StatefulWidget {
  final int id;
  PlayerMain(this.id);
  @override
  _PlayerMainState createState() => _PlayerMainState(id);
}

class _PlayerMainState extends State<PlayerMain> {
  final int id;
  _PlayerMainState(this.id);

  bool isFetching = false;
  bool isError = false;
  bool dataLoaded = false;

  var mainInform;
  var playerCounts;
  var playerHeroes;
  var playerGames;

  @override
  void initState() {
    super.initState();
    print(id);
    getData();
  }

  Future<void> getData() async {
    setState(() {
      isFetching = true;
      isError = false;
      dataLoaded = false;
    });
    try {
      final response = getPlayer('$id');
      final responseCounts = getPlayerCounts('$id');
      final responseHeroes = getPlayerHeroes('$id');
      final responseMatches = getPlayerRecentMatches('$id');
      final data = await Future.wait(
          [response, responseCounts, responseHeroes, responseMatches]);

      setState(() {
        isFetching = false;
        isError = false;
        mainInform = data[0];
        playerCounts = data[1];
        playerHeroes = data[2];
        playerGames = data[3];
        dataLoaded = true;
      });
    } catch (e) {
      setState(() {
        isFetching = false;
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget mainInfo;
    Widget lastPlayerGames;
    Widget playerHeroesW;
    Widget playerHeroesG;
    if (isError) {
      mainInfo = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              color: Color(0xffD57A66),
              size: 30.0,
              semanticLabel: 'Error',
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  ' Oops something went wrong... try later',
                  style: TextStyle(color: Color(0xffD57A66)),
                )),
          ],
        ),
      );

      lastPlayerGames = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              color: Color(0xffD57A66),
              size: 30.0,
              semanticLabel: 'Error',
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  ' Oops something went wrong... try later',
                  style: TextStyle(color: Color(0xffD57A66)),
                )),
          ],
        ),
      );

      playerHeroesW = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              color: Color(0xffD57A66),
              size: 30.0,
              semanticLabel: 'Error',
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  ' Oops something went wrong... try later',
                  style: TextStyle(color: Color(0xffD57A66)),
                )),
          ],
        ),
      );
      playerHeroesG = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              color: Color(0xffD57A66),
              size: 30.0,
              semanticLabel: 'Error',
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  ' Oops something went wrong... try later',
                  style: TextStyle(color: Color(0xffD57A66)),
                )),
          ],
        ),
      );
    }

    if (isFetching) {
      mainInfo = Center(child: CircularProgressIndicator());
      lastPlayerGames = Center(child: CircularProgressIndicator());
      playerHeroesW = Center(child: CircularProgressIndicator());
      playerHeroesG = Center(child: CircularProgressIndicator());
    }
    if (dataLoaded) {
      mainInfo = MainInfo(mainInform, playerCounts);
      lastPlayerGames = LastPlayerGames(playerGames);
      playerHeroesG = PlayerHeroes(playerHeroes);
      playerHeroesW = PlayerHeroesWinrate(playerHeroes);
    }

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Player info"),
            bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.white.withOpacity(0.3),
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    child: Text('Main info'),
                  ),
                  Tab(
                    child: Text('Last games'),
                  ),
                  Tab(
                    child: Text('Heroes by games'),
                  ),
                  Tab(
                    child: Text('Heroes by winrate'),
                  ),
                ]),
          ),
          body: TabBarView(
            children: [
              mainInfo,
              lastPlayerGames,
              playerHeroesG,
              playerHeroesW,
            ],
          ),
        ));
  }
}
