import 'package:flutter/material.dart';
import '../profile/listsModels.dart';
import 'package:provider/provider.dart';
import '../../store/player.dart';
import '../../helpers/helpers.dart';
import '../../store/appSettings.dart';
import '../../consts/const.dart';

class LastGames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Last Games')),
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<ItemGames> gamesData;
  @override
  void initState() {
    super.initState();

    gamesData =
        Provider.of<PlayerModel>(context, listen: false).gamesValueAsModel;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    final heroImgById =
        Provider.of<AppSettingsModel>(context, listen: false).heroImgById;

    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          gamesData[index].isExpanded = !isExpanded;
        });
      },
      children: gamesData.map<ExpansionPanel>((ItemGames item) {
        String isWin;
        if (item.slot > 127 && !item.radiantWin) {
          isWin = "WIN";
        } else if (item.slot < 128 && item.radiantWin) {
          isWin = "WIN";
        } else {
          isWin = "LOSE";
        }
        // String skill = item.skill
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading: Image.network(heroImgById('${item.heroId}'), height: 35),
              title: Center(
                  child: Text('${item.kills}/${item.deaths}/${item.assists}')),
              trailing: Text(
                isWin,
                style: TextStyle(
                    color:
                        isWin == "WIN" ? Color(0xff63A375) : Color(0xffD57A66),
                    fontWeight: FontWeight.bold),
              ),
            );
          },
          body: ListTile(
            title: Text('${item.id}'),
            subtitle: Row(
              children: [
                Text(modeConst['${item.mode?? 0}']),
                Text(lobbyConst['${item.lobby?? 0}']),
                Text(duration(item.duration)),
                Text(skillConst['${item.skill?? 0}']),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
