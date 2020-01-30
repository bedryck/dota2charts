import 'package:flutter/material.dart';
import '../../actions/getProMatches.dart';
import '../../helpers/helpers.dart';

class LastMatches extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<ItemMatches> gamesValueAsModel(data) {
    return data.map<ItemMatches>((game) {
      return ItemMatches(
        matchId: game['match_id'],
        duration: game['duration'],
        startTime: game['start_time'],
        radiantTeamId: game['radiant_team_id'],
        radiantName: game['radiant_name'],
        direTeamId: game['dire_team_id'],
        direName: game['dire_name'],
        leagueid: game['leagueid'],
        leagueName: game['league_name'],
        seriesId: game['series_id'],
        seriesType: game["series_type"],
        radiantScore: game["radiant_score"],
        direScore: game["dire_score"],
        radiantWin: game["radiant_win"],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Last matches'),
        ),
        body: FutureBuilder<dynamic>(
          future: getProMatches(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            Widget children;

            if (snapshot.hasData) {
              List<ItemMatches> dataGames;
              dataGames = gamesValueAsModel(snapshot.data);
              children = ListView(
                children: dataGames.map<Container>((ItemMatches item) {
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
                          children: <Widget>[
                            Expanded(
                                child: Text(
                              item.radiantName ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff63A375),
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            Container(
                                child: Row(
                              children: <Widget>[
                                item.radiantWin
                                    ? Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Icon(
                                          Icons.local_activity,
                                          color: Colors.lime,
                                          size: 17,
                                        ),
                                      )
                                    : Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Icon(
                                          Icons.local_activity,
                                          color: Colors.transparent,
                                          size: 17,
                                        ),
                                      ),
                                Container(
                                  child: Text(
                                    '${item.radiantScore}',
                                    textAlign: TextAlign.center,
                                  ),
                                  width: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'vs',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '${item.direScore}',
                                    textAlign: TextAlign.center,
                                  ),
                                  width: 20,
                                ),
                                !item.radiantWin
                                    ? Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Icon(
                                          Icons.local_activity,
                                          color: Colors.lime,
                                          size: 17,
                                        ),
                                      )
                                    : Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Icon(
                                          Icons.local_activity,
                                          color: Colors.transparent,
                                          size: 17,
                                        ),
                                      ),
                              ],
                            )),
                            Expanded(
                                child: Text(
                              item.direName ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xffD57A66),
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ],
                        )),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            duration(item.duration),
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
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
  ItemMatches(
      {this.matchId,
      this.duration,
      this.startTime,
      this.radiantTeamId,
      this.radiantName,
      this.direTeamId,
      this.direName,
      this.leagueid,
      this.leagueName,
      this.seriesId,
      this.seriesType,
      this.radiantScore,
      this.direScore,
      this.radiantWin,
      this.isExpanded = false});

  int matchId;
  int duration;
  int radiantTeamId;
  String direName;
  String radiantName;
  int direTeamId;
  int startTime;
  int leagueid;
  String leagueName;
  int seriesId;
  int seriesType;
  int radiantScore;
  int direScore;
  bool radiantWin;
  bool isExpanded;
}
