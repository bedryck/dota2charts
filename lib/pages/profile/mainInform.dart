import 'package:flutter/material.dart';
import './informChart.dart';
import './totals.dart';

class MainInform extends StatelessWidget {
  MainInform(this.screenSize, this.radianWins, this.radianGames, this.direWins,
      this.direGames, this.animation,
      {Key key})
      : super(key: key);
  final screenSize;

  final int radianWins;
  final int radianGames;
  final int direWins;
  final int direGames;
  final bool animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width,
      height: screenSize.width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: <Widget>[
          Totals(screenSize),
          Column(
            children: <Widget>[
              InformChart(
                screenSize.width,
                "Radiant",
                radianGames,
                radianWins,
                animation,
                onTap: true,
              ),
              InformChart(
                screenSize.width,
                "Dire",
                direGames,
                direWins,
                animation,
                onTap: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
