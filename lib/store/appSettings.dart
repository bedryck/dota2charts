import 'package:flutter/widgets.dart';

class AppSettingsModel extends ChangeNotifier {
  Map<String, dynamic> data;
  Map<String, dynamic> get value => data;

  String heroImgById(String id) {
    return data[id]['img'];
  }

  String heroNameById(String id) {
    return data[id]['localized_name'];
  }

  void setValue(value) {
    data = value;
    notifyListeners();
  }

  List<dynamic> patchData;
  List<dynamic> get patchValue => patchData;
  String patchName(int id) {
    return patchData != null
        ? patchData.firstWhere((patch) => patch['id'] == id)['name']
        : 'Undefined';
  }

  void setPatchValue(value) {
    patchData = value;
    notifyListeners();
  }
}
