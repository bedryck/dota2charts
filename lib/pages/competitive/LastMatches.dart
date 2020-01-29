import 'package:flutter/material.dart';
import '../../actions/getProMatches.dart';

class LastMatches extends StatefulWidget {
  @override
  _LastMatchesState createState() => _LastMatchesState();
}

class _LastMatchesState extends State<LastMatches> {
  // List<ItemMatches> dataGames;
  List<ItemMatches> dataGames = [];

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
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    var data = await getProMatches();
    setState(() {
      dataGames = gamesValueAsModel(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Last matches'),
        ),
        body: dataGames.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: dataGames.map<Container>((ItemMatches item) {
                  return Container(
                      height: 200,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(item.radiantName ?? ''),
                            // Text('vs'),
                            Text(item.direName ?? '')
                          ],
                        ),
                      ));
                }).toList(),
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
