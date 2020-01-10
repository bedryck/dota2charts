import 'package:flutter/material.dart';
import './listPreview.dart';
import 'package:provider/provider.dart';
import '../../store/player.dart';

enum InfoType {
  games,
  heroes,
}

class ListInformContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List gamesValue =
        Provider.of<PlayerModel>(context, listen: true).gamesValueAsModel;

    List heroesValue =
        Provider.of<PlayerModel>(context, listen: true).heroesValueAsModel;

    gamesValue = gamesValue.sublist(0, 3);
    heroesValue = heroesValue.sublist(0, 3);

    return Column(
      children: [
        ListPreview("Last games", gamesValue, InfoType.games, '/lastGames'),
        ListPreview("Best heroes", heroesValue, InfoType.heroes, '/bestHeroes'),
      ],
    );
  }
}
