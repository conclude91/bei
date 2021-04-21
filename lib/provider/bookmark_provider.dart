import 'dart:convert';

import 'package:bei/model/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkProvider extends ChangeNotifier {
  List<Bookmark> _listBookmark = [];

  set listBookmark(List<Bookmark> listBookmark) {
    _listBookmark = listBookmark;
    notifyListeners();
  }

  List<Bookmark> get listBookmark => _listBookmark;

  Future<List<Bookmark>> fetchAll() async {
    _listBookmark = [];
    final prefs = await SharedPreferences.getInstance();
    String tempList = prefs.getString('listBookmark');
    if (tempList != null) {
      listBookmark = (json.decode(tempList) as List<dynamic>)
          .map<Bookmark>((item) => Bookmark.fromJson(item))
          .toList();
    }
    return listBookmark;
  }
}
