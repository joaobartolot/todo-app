import 'package:flutter/foundation.dart';

class ItemTaskProvider with ChangeNotifier {
  bool _isEditing = false;
  bool get isEditing => _isEditing;
  set isEditing(bool value) {
    _isEditing = value;
    notifyListeners();
  }
}
