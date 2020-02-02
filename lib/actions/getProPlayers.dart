import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> getProPlayers() async {
  final response = await http.get('https://api.opendota.com/api/proPlayers');

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load pro matches');
  }
}

Future<List<dynamic>> getTeamPlayers(int teamID) async {
  final response =
      await http.get('https://api.opendota.com/api/teams/$teamID/players');

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load pro matches');
  }
}
