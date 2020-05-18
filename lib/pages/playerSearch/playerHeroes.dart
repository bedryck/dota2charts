import 'package:flutter/material.dart';
import '../../helpers/helpers.dart';
import 'package:provider/provider.dart';
import '../../store/appSettings.dart';

class PlayerHeroes extends StatelessWidget {
  final playerHeroes;
  PlayerHeroes(this.playerHeroes);

  @override
  Widget build(BuildContext context) {
    final heroImgById =
        Provider.of<AppSettingsModel>(context, listen: false).heroImgById;
    final heroNameById =
        Provider.of<AppSettingsModel>(context, listen: false).heroNameById;
    final data = heroesValueAsModel(playerHeroes);
    List<Widget> itemsList = data.map<ListTile>((item) {
      return ListTile(
        leading: Image.network(heroImgById(item.heroId), height: 40),
        title: Text(heroNameById(item.heroId) ?? 'Unknown'),
        subtitle: Row(
          children: <Widget>[
            Text('${item.games} games'),
            Text('${proz(item.games, item.win)}% winrate')
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      );
    }).toList();

    return ListView(shrinkWrap: true, children: itemsList);
  }
}

heroesValueAsModel(data) {
  return data.map<ItemHeroes>((hero) {
    return ItemHeroes(
        heroId: hero['hero_id'],
        lastPlayed: hero['last_played'],
        games: hero['games'],
        win: hero['win'],
        withGames: hero['with_games'],
        withWin: hero['with_win'],
        againstGames: hero['against_games'],
        againstWin: hero['against_win']);
  }).toList();
}

class ItemHeroes {
  ItemHeroes({
    this.heroId,
    this.lastPlayed,
    this.games,
    this.win,
    this.withGames,
    this.withWin,
    this.againstGames,
    this.againstWin,
  });

  String heroId;
  int lastPlayed;
  int games;
  int win;
  int withGames;
  int withWin;
  int againstGames;
  int againstWin;
}
