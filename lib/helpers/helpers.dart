duration<String>(int seconds) {
  int days = (seconds / 86400).floor();
  int houvers = ((seconds - days * 86400) / 3600).floor();
  int minutes = ((seconds - days * 86400 - houvers * 3600) / 60).floor();

  if (houvers == 0 && days == 0) {
    return '${minutes}m';
  }
  if (days == 0) {
    return '${houvers}h ${minutes}m';
  }

  return '${days}d ${houvers}h ${minutes}m';
}

proz<num>(int totals, int minTotals) {
  if (minTotals == null || totals == null || totals == 0) return '0.00';
  return (minTotals * 100 / totals).toStringAsFixed(2);
}

when<String>(int date) {
  int dateNow = new DateTime.now().millisecondsSinceEpoch;

  return duration(((dateNow - date * 1000) / 1000).round());
}
