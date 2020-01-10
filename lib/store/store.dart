
import 'package:flutter/widgets.dart';

class UserModel extends ChangeNotifier {
  String id = '';

  String get currentId => id;

  void setId(value) {
    id = value;
    // notifyListeners();
  }
}
