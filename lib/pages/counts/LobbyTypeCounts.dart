import 'package:flutter/material.dart';
import '../../charts/HorizontalBarChart .dart';
import '../../consts/const.dart';
import 'package:provider/provider.dart';
import '../../store/player.dart';

class CountsList {
  String mode;
  Map value;
  CountsList(this.mode, this.value);
}

class CountsLobby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List countsModeList = List();

    bool isDark;

    final ThemeData theme = Theme.of(context);
    isDark = theme.brightness == Brightness.dark;

    Map<String, dynamic> countsMode =
        Provider.of<PlayerModel>(context, listen: false).countsLobby;
    countsMode.forEach((k, v) => countsModeList.add(CountsList(k, v)));

    List<HorizontalModel> data = countsModeList.map((item) {
      return HorizontalModel(
          lobbyConst[item.mode], item.value['games'], item.value['win']);
    }).toList();

    return Consumer<PlayerModel>(builder: (context, player, child) {
      return Container(
        height: data.length * 50.0 + 20,
        child: Card(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text('Lobby winrate'),
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
                    child: HorizontalBarChart.withSampleData(data, isDark)),
              )
            ],
          ),
        ),
      );
    });
  }
}
