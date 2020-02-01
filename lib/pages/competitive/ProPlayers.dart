import 'package:flutter/material.dart';
import '../../actions/getProPlayers.dart';

class ProPlayers extends StatelessWidget {
  final pngReExp = RegExp('.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pro teams'),
        ),
        body: FutureBuilder<dynamic>(
          future: getProPlayers(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            Widget children;

            if (snapshot.hasData) {
              List<ItemPlayer> dataTeams;
              dataTeams = teamsValueAsModel(snapshot.data);
              List<Widget> dataRender =
                  dataTeams.map<Container>((ItemPlayer item) {
                return Container(
                    child: Card(
                  child: ListTile(
                    leading: Container(
                      width: 35.0,
                      height: 35.0,
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        image: DecorationImage(
                          image: NetworkImage(item.avatarmedium),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(item.name ?? ''),
                    subtitle: Wrap(
                      children: <Widget>[
                        Text('Id: ${item.accountId}'),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text('Team: ${item.teamName}'),
                        )
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
    this.avatarmedium,
    this.name,
    this.teamName,
  });

  int accountId;
  String avatarmedium;
  String teamName;
  String name;
}

List<ItemPlayer> teamsValueAsModel(data) {
  return data.map<ItemPlayer>((item) {
    return ItemPlayer(
      accountId: item['account_id'],
      avatarmedium: item['avatarmedium'],
      name: item['name'],
      teamName: item['team_name'],
    );
  }).toList();
}
