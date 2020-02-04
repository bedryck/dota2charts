import 'package:flutter/material.dart';
import '../../actions/getProPlayers.dart';
import '../playerSearch/playerMain.dart';

class CurrentTeamPlayers extends StatelessWidget {
  final int teamID;
  final String teamName;
  CurrentTeamPlayers(this.teamID, this.teamName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Current team $teamName players'),
        ),
        body: FutureBuilder<dynamic>(
          future: getTeamPlayers(teamID),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            Widget children;

            if (snapshot.hasData) {
              List<ItemPlayer> dataTeams;
              dataTeams = teamsValueAsModel(snapshot.data);
              dataTeams = dataTeams
                  .where((f) => f.isCurrentTeamMember == true)
                  .toList();
              List<Widget> dataRender =
                  dataTeams.map<Container>((ItemPlayer item) {
                return Container(
                    child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlayerMain(item.accountId)),
                      );
                    },
                    title: Text(item.name ?? ''),
                    subtitle: Wrap(
                      children: <Widget>[
                        Text('Id: ${item.accountId}'),
                      ],
                    ),
                  ),
                ));
              }).toList();
              children = ListView(children: dataRender);
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

class ItemPlayer {
  ItemPlayer({
    this.accountId,
    this.name,
    this.gamesPlayed,
    this.wins,
    this.isCurrentTeamMember,
  });

  int accountId;
  String name;
  int gamesPlayed;
  int wins;
  bool isCurrentTeamMember;
}

List<ItemPlayer> teamsValueAsModel(data) {
  return data.map<ItemPlayer>((item) {
    return ItemPlayer(
      accountId: item['account_id'],
      name: item['name'],
      gamesPlayed: item['games_played'],
      wins: item['wins'],
      isCurrentTeamMember: item['is_current_team_member'],
    );
  }).toList();
}
