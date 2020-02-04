import 'package:flutter/material.dart';
import '../../ui/rank.dart';
import '../../actions/getProMatches.dart';
import '../../helpers/helpers.dart';
import '../profile/informChart.dart';

class MainInfo extends StatelessWidget {
  final mainInform;
  final playerCounts;
  MainInfo(this.mainInform, this.playerCounts);
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
          child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  image: DecorationImage(
                    image: NetworkImage(mainInform['profile']['avatarfull']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                  child: Text(
                mainInform['profile']['personaname'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ))
            ],
          ),
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: <Widget>[
                  Image(height: 20, image: AssetImage('images/steam.png')),
                  Text(
                    '  ID: ${mainInform['profile']['account_id']}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(children: [
                Text(
                  "Rank:",
                  style: TextStyle(fontSize: 17),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: 50,
                  height: 50,
                  child: Rank(
                      rank: mainInform['rank_tier'] != null
                          ? mainInform['rank_tier'].toString()[0]
                          : '0',
                      stars: mainInform['rank_tier'] != null
                          ? mainInform['rank_tier'].toString()[1]
                          : '0',
                      position: ''),
                )
              ])),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(children: [
              Container(
                child: Text(
                  'WIn ratee: ${proz(playerCounts['is_radiant']['0']['games'] + playerCounts['is_radiant']['1']['games'], playerCounts['is_radiant']['0']['win'] + playerCounts['is_radiant']['1']['win'])}%',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                ),
              )
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(left: 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InformChart(
                    screenSize.width - 40,
                    "Radiant",
                    playerCounts['is_radiant']['1']['games'],
                    playerCounts['is_radiant']['1']['win'],
                    true,
                    onTap: false,
                  ),
                  InformChart(
                    screenSize.width - 40,
                    "Dire",
                    playerCounts['is_radiant']['0']['games'],
                    playerCounts['is_radiant']['0']['win'],
                    true,
                    onTap: false,
                  ),
                ]),
          )
        ],
      )),
    );
  }
}
