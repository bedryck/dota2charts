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
