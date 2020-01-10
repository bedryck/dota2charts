import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getPlayer(String id) async {
  final response = await http.get(
      'https://raw.githubusercontent.com/bedryck/mockDotaCharts/master/player.json');

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    if (data is Map && data['error'] != null) throw Exception(data['error']);
    return data;
  } else {
    throw Exception('Failed to load player info');
  }
}

Future<List<dynamic>> getPlayerTotals(String id) async {
  final response = await http.get(
      'https://raw.githubusercontent.com/bedryck/mockDotaCharts/master/totals.json');

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    if (data is Map && data['error'] != null) throw Exception(data['error']);
    return data;
  } else {
    throw Exception('Failed to load player info');
  }
}

Future<Map<String, dynamic>> getPlayerCounts(String id) async {
  final response = await http.get(
      'https://raw.githubusercontent.com/bedryck/mockDotaCharts/master/counts.json');

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    if (data is Map && data['error'] != null) throw Exception(data['error']);
    return data;
  } else {
    throw Exception('Failed to load player info');
  }
}

Future<List<dynamic>> getPlayerRecentMatches(String id) async {
  final response = await http.get(
      'https://raw.githubusercontent.com/bedryck/mockDotaCharts/master/recentMatches.json');

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    if (data is Map && data['error'] != null) throw Exception(data['error']);
    return data;
  } else {
    throw Exception('Failed to load player info');
  }
}

Future<List<dynamic>> getPlayerHeroes(String id) async {
  final response = await http.get(
      'https://raw.githubusercontent.com/bedryck/mockDotaCharts/master/heroes.json');

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    if (data is Map && data['error'] != null) throw Exception(data['error']);
    return data;
  } else {
    throw Exception('Failed to load player info');
  }
}
