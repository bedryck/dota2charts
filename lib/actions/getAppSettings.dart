import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getAppSettings() async {
  final response = await http.get(
      'https://raw.githubusercontent.com/bedryck/mockDotaCharts/master/heroSettings.json');

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load player info');
  }
}

Future<List<dynamic>> getPatchAppSettings() async {
  final response = await http.get(
      'https://raw.githubusercontent.com/bedryck/mockDotaCharts/master/patchSettings.json');

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load player info');
  }
}
