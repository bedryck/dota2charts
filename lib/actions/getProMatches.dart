import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> getProMatches() async {
  final response = await http.get('https://api.opendota.com/api/proMatches');

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load pro matches');
  }
}
