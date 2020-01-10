import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> getPlayerList(value) async {
  final response =
      await http.get('https://api.opendota.com/api/search?q=$value');

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load player info');
  }
}
