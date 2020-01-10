import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../store/player.dart';
import '../../store/appSettings.dart';
import '../../helpers/helpers.dart';
import '../profile/listsModels.dart';

class BestHeroes extends StatefulWidget {
  @override
  _BestHeroesState createState() => _BestHeroesState();
}

class _BestHeroesState extends State<BestHeroes> {
  String _sortBy = 'games';
  bool direction = true;

  void _select(String selectValue) {
    setState(() {
      _sortBy = selectValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    List heroesValue =
        Provider.of<PlayerModel>(context, listen: true).heroesValueAsModel;

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Heroes"),
            actions: <Widget>[
              Center(child: Text('Sorted by $_sortBy')),
              PopupMenuButton(
                onSelected: _select,
                itemBuilder: (BuildContext context) {
                  return [
                    _sortBy == 'games'
                        ? PopupMenuItem(
                            child: Text('Sort by winrate'),
                            value: 'winrate',
                          )
                        : PopupMenuItem(
                            child: Text('Sort by games'),
                            value: 'games',
                          ),
                  ];
                },
              )
            ],
            bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.white.withOpacity(0.3),
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    child: Text('Playing for this hero'),
                  ),
                  Tab(
                    child: Text('Playing with this hero'),
                  ),
                  Tab(
                    child: Text('Playing against this hero'),
                  ),
                ]),
          ),
          body: TabBarView(
            children: [
              forHero(context, heroesValue, _sortBy, direction),
              withHero(context, heroesValue, _sortBy, direction),
              againstHero(context, heroesValue, _sortBy, direction),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.swap_vert),
            onPressed: () {
              setState(() {
                direction = !direction;
              });
            },
          ),
        ));
  }
}

Widget forHero(context, data, sortBy, direction) {
  final heroImgById =
      Provider.of<AppSettingsModel>(context, listen: false).heroImgById;
  final heroNameById =
      Provider.of<AppSettingsModel>(context, listen: false).heroNameById;

  if (direction) {
    switch (sortBy) {
      case 'winrate':
        data.sort((ItemHeroes a, ItemHeroes b) =>
            (b.games == 0 ? 0 : b.win * 100.0 / b.games)
                .compareTo((a.games == 0 ? 0 : a.win * 100.0 / a.games)));
        break;

      default:
    }
  } else {
    switch (sortBy) {
      case 'winrate':
        data.sort((ItemHeroes a, ItemHeroes b) =>
            (a.games == 0 ? 0 : a.win * 100.0 / a.games)
                .compareTo((b.games == 0 ? 0 : b.win * 100.0 / b.games)));
        break;
      case 'games':
        data.sort((ItemHeroes a, ItemHeroes b) => a.games.compareTo(b.games));
        break;

      default:
    }
  }

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

Widget withHero(context, data, sortBy, direction) {
  final heroImgById =
      Provider.of<AppSettingsModel>(context, listen: false).heroImgById;
  final heroNameById =
      Provider.of<AppSettingsModel>(context, listen: false).heroNameById;

  if (direction) {
    switch (sortBy) {
      case 'games':
        data.sort(
            (ItemHeroes a, ItemHeroes b) => b.withGames.compareTo(a.withGames));

        break;
      case 'winrate':
        data.sort((ItemHeroes a, ItemHeroes b) =>
            (b.withGames == 0 ? 0 : b.withWin * 100.0 / b.withGames).compareTo(
                (a.withGames == 0 ? 0 : a.withWin * 100.0 / a.withGames)));

        break;
      default:
    }
  } else {
    switch (sortBy) {
      case 'games':
        data.sort(
            (ItemHeroes a, ItemHeroes b) => a.withGames.compareTo(b.withGames));

        break;
      case 'winrate':
        data.sort((ItemHeroes a, ItemHeroes b) =>
            (a.withGames == 0 ? 0 : a.withWin * 100.0 / a.withGames).compareTo(
                (b.withGames == 0 ? 0 : b.withWin * 100.0 / b.withGames)));

        break;
      default:
    }
  }

  List<Widget> itemsList = data.map<ListTile>((item) {
    return ListTile(
      isThreeLine: true,
      leading: Image.network(heroImgById(item.heroId), height: 40),
      title: Text(heroNameById(item.heroId) ?? 'Unknown'),
      subtitle: Column(
        children: <Widget>[
          Text('${item.withGames} games with this hero'),
          Text('${proz(item.withGames, item.withWin)}% winrate with this hero')
        ],
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }).toList();

  return ListView(shrinkWrap: true, children: itemsList);
}

Widget againstHero(context, data, sortBy, direction) {
  final heroImgById =
      Provider.of<AppSettingsModel>(context, listen: false).heroImgById;
  final heroNameById =
      Provider.of<AppSettingsModel>(context, listen: false).heroNameById;
  if (direction) {
    switch (sortBy) {
      case 'games':
        data.sort((ItemHeroes a, ItemHeroes b) =>
            b.againstGames.compareTo(a.againstGames));

        break;
      case 'winrate':
        data.sort((ItemHeroes a, ItemHeroes b) =>
            (b.againstGames == 0 ? 0 : b.againstWin * 100.0 / b.againstGames)
                .compareTo((a.againstGames == 0
                    ? 0
                    : a.againstWin * 100.0 / a.againstGames)));

        break;
      default:
    }
  } else {
    switch (sortBy) {
      case 'games':
        data.sort((ItemHeroes a, ItemHeroes b) =>
            a.againstGames.compareTo(b.againstGames));

        break;
      case 'winrate':
        data.sort((ItemHeroes a, ItemHeroes b) =>
            (a.againstGames == 0 ? 0 : a.againstWin * 100.0 / a.againstGames)
                .compareTo((b.againstGames == 0
                    ? 0
                    : b.againstWin * 100.0 / b.againstGames)));

        break;
      default:
    }
  }

  List<Widget> itemsList = data.map<ListTile>((item) {
    return ListTile(
      isThreeLine: true,
      leading: Image.network(heroImgById(item.heroId), height: 40),
      title: Text(heroNameById(item.heroId) ?? 'Unknown'),
      subtitle: Column(
        children: <Widget>[
          Text('${item.againstGames} games against this hero'),
          Text(
              '${proz(item.againstGames, item.againstWin)}% winrate against this hero')
        ],
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }).toList();

  return ListView(shrinkWrap: true, children: itemsList);
}

winrate<num>(int total, int part) {
  return part * 100 / total;
}
