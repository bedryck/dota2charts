import 'package:flutter/material.dart';
import '../../actions/getProTeams.dart';
import '../../helpers/helpers.dart';

class ProTeams extends StatelessWidget {
  final pngReExp = RegExp('.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pro teams'),
        ),
        body: FutureBuilder<dynamic>(
          future: getProTeams(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            Widget children;

            if (snapshot.hasData) {
              List<ItemTeams> dataTeams;
              dataTeams = teamsValueAsModel(snapshot.data);
              List<Widget> dataRender =
                  dataTeams.map<Container>((ItemTeams item) {
                return Container(
                    child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: item.logoUrl != null &&
                              pngReExp.hasMatch(item.logoUrl)
                          ? Image.network(
                              item.logoUrl,
                              height: 25,
                            )
                          : null,
                    ),
                    title: Text(item.name ?? ''),
                    subtitle: Row(
                      children: <Widget>[
                        Text('Rating: ${item.rating}'),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                              'Winrate: ${proz(item.wins + item.losses, item.wins)}'),
                        )
                      ],
                    ),
                    trailing: PopupMenuButton(
                      onSelected: (value) {},
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            child: Text('Matches'),
                            value: 'matches',
                          ),
                          PopupMenuItem(
                            child: Text('Players'),
                            value: 'players',
                          ),
                         
                        ];
                      },
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

class ItemTeams {
  ItemTeams({
    this.teamId,
    this.rating,
    this.wins,
    this.losses,
    this.lastMatchTime,
    this.name,
    this.tag,
    this.logoUrl,
  });

  int teamId;
  num rating;
  int losses;
  String tag;
  int lastMatchTime;
  String name;
  int wins;
  String logoUrl;
}

List<ItemTeams> teamsValueAsModel(data) {
  return data.map<ItemTeams>((item) {
    return ItemTeams(
      teamId: item['team_id'],
      rating: item['rating'],
      losses: item['losses'],
      tag: item['tag'],
      lastMatchTime: item['last_match_time'],
      name: item['name'],
      wins: item['wins'],
      logoUrl: item['logo_url'],
    );
  }).toList();
}
