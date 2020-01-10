import 'package:flutter/widgets.dart';
import '../helpers/helpers.dart';
import '../pages/profile/listsModels.dart';

class PlayerModel extends ChangeNotifier {
  Map<String, dynamic> data;
  Map<String, dynamic> get value => data;
  String get profileImage => data != null ? data["profile"]["avatar"] : '';
  dynamic get profileId => data != null ? data['profile']['account_id'] : '';
  String get profileName => data != null ? data['profile']['personaname'] : '';

  String get profileRank => data != null && data['rank_tier'] != null
      ? data['rank_tier'].toString()[0]
      : '0';
  String get profileStars => data != null && data['rank_tier'] != null
      ? data['rank_tier'].toString()[1]
      : '0';

  void setValue(value) {
    data = value;
    notifyListeners();
  }

  List<dynamic> dataTotals;
  List<dynamic> get totalsValue => dataTotals;
  num get totalDuration => dataTotals != null
      ? dataTotals.firstWhere((total) => total['field'] == 'duration')['sum']
      : 0;
  num get totalKills => dataTotals != null
      ? dataTotals.firstWhere((total) => total['field'] == 'kills')['sum']
      : 0;
  num get totalDeaths => dataTotals != null
      ? dataTotals.firstWhere((total) => total['field'] == 'deaths')['sum']
      : 0;
  num get totalAssists => dataTotals != null
      ? dataTotals.firstWhere((total) => total['field'] == 'assists')['sum']
      : 0;
  num get totalLastHits => dataTotals != null
      ? dataTotals.firstWhere((total) => total['field'] == 'last_hits')['sum']
      : 0;
  num get totalDenies => dataTotals != null
      ? dataTotals.firstWhere((total) => total['field'] == 'denies')['sum']
      : 0;
  num get totalKda => dataTotals != null
      ? dataTotals.firstWhere((total) => total['field'] == 'kda')['sum']
      : 0;
  num get totalGold => dataTotals != null
      ? dataTotals
          .firstWhere((total) => total['field'] == 'gold_per_min')['sum']
      : 0;
  num get totalXp => dataTotals != null
      ? dataTotals.firstWhere((total) => total['field'] == 'xp_per_min')['sum']
      : 0;
  num get totalLevel => dataTotals != null
      ? dataTotals.firstWhere((total) => total['field'] == 'level')['sum']
      : 0;

  num get totalGames => dataTotals != null ? dataTotals[0]["n"] : 0;

  void setTotalsValue(value) {
    dataTotals = value;
    notifyListeners();
  }

  Map<String, dynamic> dataCounts;
  Map<String, dynamic> get countsValue => dataCounts;
  Map<String, dynamic> get countsRadiant => dataCounts != null
      ? dataCounts['is_radiant']["1"]
      : {"games": 0, "win": 0};
  Map<String, dynamic> get countsDire => dataCounts != null
      ? dataCounts['is_radiant']["0"]
      : {"games": 0, "win": 0};

  dynamic get winRate => dataCounts != null
      ? proz(countsRadiant['games'] + countsDire['games'],
          countsRadiant['win'] + countsDire['win'])
      : '';

  Map<String, dynamic> get countsMode =>
      dataCounts != null ? dataCounts['game_mode'] : {};
  Map<String, dynamic> get countsLobby =>
      dataCounts != null ? dataCounts['lobby_type'] : {};
  Map<String, dynamic> get countsRegion =>
      dataCounts != null ? dataCounts['region'] : {};
  Map<String, dynamic> get countsPatch =>
      dataCounts != null ? dataCounts['patch'] : {};

  void setCountsValue(value) {
    dataCounts = value;
    notifyListeners();
  }

  List<dynamic> dataHeroes = [];
  List<dynamic> get heroesValue => dataHeroes;

  List<ItemHeroes> get heroesValueAsModel {
    return dataHeroes.map<ItemHeroes>((hero) {
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

  void setHeroesValue(value) {
    dataHeroes = value;
    notifyListeners();
  }

  List<dynamic> dataGames = [];
  List<dynamic> get gamesValue => dataGames;

  List<ItemGames> get gamesValueAsModel {
    return dataGames.map<ItemGames>((game) {
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
      );
    }).toList();
  }

  void setGamesValue(value) {
    dataGames = value;
    notifyListeners();
  }
}
