import 'package:flutter/material.dart';
import '../../charts/HorizontalBarChart.dart';
import 'package:provider/provider.dart';
import '../../store/player.dart';
import '../../store/appSettings.dart';

class CountsList {
  String mode;
  Map value;
  CountsList(this.mode, this.value);
}

class CountsPatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final patchName =
        Provider.of<AppSettingsModel>(context, listen: false).patchName;

    bool isDark;

    final ThemeData theme = Theme.of(context);
    isDark = theme.brightness == Brightness.dark;

    List countsModeList = List();

    Map<String, dynamic> countsMode =
        Provider.of<PlayerModel>(context, listen: false).countsPatch;
    countsMode.forEach((k, v) => countsModeList.add(CountsList(k, v)));

    List<HorizontalModel> data = countsModeList.map((item) {
      return HorizontalModel(patchName(int.parse(item.mode)),
          item.value['games'], item.value['win']);
    }).toList();

    return Consumer<PlayerModel>(builder: (context, player, child) {
      return Container(
        height: data.length * 50.0 + 20,
        child: Card(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text('Patch winrate'),
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
