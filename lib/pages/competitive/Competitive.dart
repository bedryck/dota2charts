import 'package:flutter/material.dart';
import './LastMatches.dart';
import './ProTeams.dart';
import './ProPlayers.dart';

class Competitive extends StatelessWidget {
  onPushRoute(context, widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Competitive dota'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: <Widget>[
          _card(context, 'Last matches', 'images/matches.jpg',
              () => onPushRoute(context, LastMatches())),
          _card(context, 'Pro teams', 'images/teams.png',
              () => onPushRoute(context, ProTeams())),
          _card(context, 'Pro players', 'images/players.jpg',
              () => onPushRoute(context, ProPlayers())),
        ],
      ),
    );
  }
}

Widget _card(BuildContext context, text, img, onTap) {
  return SizedBox(
    height: 200,
    child: Card(
      // This ensures that the Card's children are clipped correctly.
      clipBehavior: Clip.antiAlias,
      // shape: shape,
      child: InkWell(
        onTap: onTap,
        child: Stack(children: <Widget>[
          Container(
            // color: Colors.red,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(img),
              fit: BoxFit.cover,
            )),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            height: 50,
            child: Container(
              padding: EdgeInsets.only(left: 20),
              color: Colors.black45,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ]),
      ),
    ),
  );
}
