import 'package:flutter/material.dart';

class LanguageProvidder extends ChangeNotifier {
  bool _language = false; // false bahasa, true english

  bool get language => _language;
  set language(bool language) {
    _language = language;
    notifyListeners();
  }
}
