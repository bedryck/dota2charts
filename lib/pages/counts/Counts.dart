import 'package:flutter/material.dart';
import '../profile/informChart.dart';
import '../../store/player.dart';
import 'package:provider/provider.dart';

import './CountsMode.dart';
import './LobbyTypeCounts.dart';
import './CountsRegion.dart';
import './CountsPatch.dart';

class Counts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text("Counts"),
        ),
        body: ListView(padding: EdgeInsets.all(10), children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Consumer<PlayerModel>(builder: (context, player, child) {
                return InformChart(
                  screenSize.width + 20,
                  "Radiant",
                  player.countsRadiant['games'],
                  player.countsRadiant['win'],
                  true,
                );
              }),
              Consumer<PlayerModel>(builder: (context, player, child) {
                return InformChart(
                  screenSize.width + 20,
                  "Dire",
                  player.countsDire['games'],
                  player.countsDire['win'],
                  true,
                );
              }),
            ],
          ),
          CountsMode(),
          CountsLobby(),
          CountsRegion(),
          CountsPatch()
        ]));
  }
}
