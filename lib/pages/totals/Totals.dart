import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../store/player.dart';
import '../../helpers/helpers.dart';

class Totals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Consumer<PlayerModel>(builder: (context, player, child) {
        return Text("Totals in ${player.totalGames} games");
      }),
    ), body: Consumer<PlayerModel>(builder: (context, player, child) {
      return ListView(
        children: <Widget>[
          ListTile(
            title: Text('${player.totalKills}'),
            subtitle: Text('Kills'),
          ),
          ListTile(
            title: Text('${player.totalDeaths}'),
            subtitle: Text('Deaths'),
          ),
          ListTile(
            title: Text('${player.totalAssists}'),
            subtitle: Text('Assists'),
          ),
          ListTile(
            title: Text('${player.totalLastHits}'),
            subtitle: Text('Last hits'),
          ),
          ListTile(
            title: Text('${player.totalDenies}'),
            subtitle: Text('Denies'),
          ),
          ListTile(
            title: Text('${player.totalKda}'),
            subtitle: Text('Kda'),
          ),
          ListTile(
            title: Text('${duration(player.totalDuration)}'),
            subtitle: Text('Duration'),
          ),
          ListTile(
            title: Text('${player.totalGold}'),
            subtitle: Text('Gold per minutes'),
          ),
          ListTile(
            title: Text('${player.totalXp}'),
            subtitle: Text('Expirience per minutes'),
          ),
          ListTile(
            title: Text('${player.totalLevel}'),
            subtitle: Text('Level'),
          )
        ],
      );
    }));
  }
}
