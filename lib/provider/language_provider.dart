import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  bool _language = false; // false bahasa, true english

  bool get language => _language;

  set language(bool language) {
    _language = language;
    notifyListeners();
  }

  Future<bool> fetchAll() async {
    final prefs = await SharedPreferences.getInstance();
    bool tempLanguage = prefs.getBool('language');
    if (tempLanguage != null) {
      _language = tempLanguage;
    }
    return language;
  }
}
