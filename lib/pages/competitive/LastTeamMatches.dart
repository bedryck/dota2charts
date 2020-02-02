import 'package:flutter/material.dart';
import '../../actions/getProMatches.dart';
import '../../helpers/helpers.dart';

class LastTeamMatches extends StatelessWidget {
  final int teamID;
  final String teamName;
  final pngReExp = RegExp('.png');

  LastTeamMatches(this.teamID, this.teamName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Last team $teamName matches'),
        ),
        body: FutureBuilder<dynamic>(
          future: getProMatchesByID(teamID),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            Widget children;

            if (snapshot.hasData) {
              List<ItemMatches> dataGames;
              dataGames = gamesValueAsModel(snapshot.data);
              children = ListView(
                children: dataGames.map<Container>((ItemMatches item) {
                  String isWin =
                      item.radiant == item.radiantWin ? "WIN" : "LOOSE";
                  return Container(
                      child: Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            item.leagueName ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: 45,
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  isWin,
                                  style: TextStyle(
                                      color: isWin == "WIN"
                                          ? Color(0xff63A375)
                                          : Color(0xffD57A66),
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Text('Opposing team:')),
                            Container(
                                child: Row(children: [
                              CircleAvatar(
                                child: item.opposingTeamLogo != null &&
                                        pngReExp.hasMatch(item.opposingTeamLogo)
                                    ? Image.network(
                                        item.opposingTeamLogo,
                                        height: 25,
                                      )
                                    : null,
                              ),
                              Container(
                                width: 100,
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  item.opposingTeamName ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ])),
                          ],
                        )),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "${when(item.duration + item.startTime)} ago",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  duration(item.duration),
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            ]),
                      ],
                    ),
                  ));
                }).toList(),
              );
            } else if (snapshot.hasError) {
              children = Center(
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
                          ' Oops something went wrong... ${snapshot.error}',
                          style: TextStyle(color: Color(0xffD57A66)),
                        )),
                  ],
                ),
              );
            } else {
              children = Center(
                child: CircularProgressIndicator(),
              );
            }
            return children;
          },
        ));
  }
}

class ItemMatches {
  ItemMatches({
    this.matchId,
    this.duration,
    this.radiantWin,
    this.radiant,
    this.startTime,
    this.leagueid,
    this.leagueName,
    this.cluster,
    this.opposingTeamId,
    this.opposingTeamName,
    this.opposingTeamLogo,
  });

  int matchId;
  int duration;
  bool radiantWin;
  bool radiant;
  int startTime;
  int leagueid;
  String leagueName;
  int cluster;
  int opposingTeamId;
  String opposingTeamName;
  String opposingTeamLogo;
}

List<ItemMatches> gamesValueAsModel(data) {
  return data.map<ItemMatches>((game) {
    return ItemMatches(
        matchId: game['match_id'],
        duration: game['duration'],
        startTime: game['start_time'],
        leagueid: game['leagueid'],
        leagueName: game['league_name'],
        radiantWin: game["radiant_win"],
        cluster: game['cluster'],
        opposingTeamId: game['opposing_team_id'],
        opposingTeamName: game['opposing_team_name'],
        opposingTeamLogo: game['opposing_team_logo'],
        radiant: game['radiant']);
  }).toList();
}
