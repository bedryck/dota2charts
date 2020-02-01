import 'package:flutter/material.dart';
import '../../charts/winLoseChart.dart';

class InformChart extends StatelessWidget {
  final double width;
  final String label;
  final int games;
  final int wins;
  final bool animation;
  final bool onTap;
  InformChart(this.width, this.label, this.games, this.wins, this.animation,
      {this.onTap = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width / 2,
      width: width / 2 - 20,
      child: Card(
          child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                child: Text(label),
                margin: EdgeInsets.only(top: 10),
              ),
              Expanded(
                  child: wins != null || wins != 0
                      ? WinLoseChart.withSampleData(
                          wins, games - wins, animation)
                      : Container()),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: Color(0xffD57A66),
                        borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  ),
                  Text('- loses'),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: Color(0xff63A375),
                        borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  ),
                  Text('- wins'),
                ],
              )
            ],
          ),
          onTap
              ? Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/counts');
                    },
                  ),
                )
              : Container()
        ],
      )),
    );
  }
}
