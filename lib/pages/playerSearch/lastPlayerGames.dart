import 'package:flutter/material.dart';
import '../../actions/getProMatches.dart';
import '../../helpers/helpers.dart';
import '../../consts/const.dart';
import 'package:provider/provider.dart';
import '../../store/appSettings.dart';

class LastPlayerGames extends StatefulWidget {
  final playerGames;

  LastPlayerGames(this.playerGames);
  @override
  _LastPlayerGamesState createState() => _LastPlayerGamesState(playerGames);
}

class _LastPlayerGamesState extends State<LastPlayerGames> {
  final playerGames;
  _LastPlayerGamesState(this.playerGames);

  List<ItemGames> gamesData;

  @override
  void initState() {
    super.initState();

    gamesData = gamesValueAsModel(playerGames);
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
                Text(modeConst['${item.mode ?? 0}']),
                Text(lobbyConst['${item.lobby ?? 0}']),
                Text(duration(item.duration)),
                Text(skillConst['${item.skill ?? 0}']),
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

gamesValueAsModel(data) {
  return data.map<ItemGames>((game) {
    return ItemGames(
        heroId: game['hero_id'],
        kills: game['kills'],
        assists: game['assists'],
        id: game['match_id'],
        slot: game['player_slot'],
        radiantWin: game['radiant_win'],
        deaths: game['deaths'],
        duration: game['duration'],
        mode: game['game_mode'],
        skill: game['skill'],
        lobby: game["lobby_type"],
        startTime: game['start_time']);
  }).toList();
}

class ItemGames {
  ItemGames({
    this.heroId,
    this.kills,
    this.assists,
    this.id,
    this.slot,
    this.radiantWin,
    this.isExpanded = false,
    this.deaths,
    this.duration,
    this.mode,
    this.skill,
    this.lobby,
    this.startTime,
  });

  int heroId;
  int kills;
  int id;
  bool isExpanded;
  int slot;
  bool radiantWin;
  int assists;
  int deaths;
  int duration;
  int mode;
  int skill;
  int lobby;
  int startTime;
}
