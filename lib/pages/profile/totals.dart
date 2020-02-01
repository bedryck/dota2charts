import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../store/player.dart';

class Totals extends StatelessWidget {
  Totals(this.screenSize, {Key key}) : super(key: key);
  final screenSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: screenSize.width,
        width: screenSize.width / 2 - 20,
        child: Card(
          child: InkWell(
            onTap: (){
               Navigator.pushNamed(context, '/totals');
            },
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  child: Text(
                    'Totals in all games',
                  ),
                  margin: EdgeInsets.only(top: 10),
                ),
              ),
              Expanded(
                child: Consumer<PlayerModel>(builder: (context, player, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      totalItem(context, 'KILLS', '${player.totalKills}'),
                      totalItem(context, 'DEATHS', '${player.totalDeaths}'),
                      totalItem(context, 'ASSISTS', '${player.totalAssists}'),
                      totalItem(
                          context, 'LAST HITS', '${player.totalLastHits}'),
                      totalItem(context, 'DENIES', '${player.totalDenies}'),
                    ],
                  );
                }),
              )
            ],
          )),
        ),
      ),
    );
  }
}

Widget totalItem(BuildContext context, String name, String value) {
  return Container(
    margin: EdgeInsets.only(left: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$name:',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
        ),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
        )
      ],
    ),
  );
}
