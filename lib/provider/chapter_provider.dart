import 'dart:convert';

import 'package:bei/consts/constanta.dart';
import 'package:bei/model/chapter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChapterProvider extends ChangeNotifier {
  List<Chapter> _listChapter = [];

  List<Chapter> get listChapter => _listChapter;

  set listChapter(List<Chapter> listChapter) {
    _listChapter = listChapter;
    notifyListeners();
  }

  Future<List<Chapter>> fetchAll() async {
    _listChapter = [];
    final response = await http.get(Uri.parse(Constanta.GET_CHAPTERS));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> result = map['result'];
    if (result.length > 0) {
      for (int i = 0; i < result.length; i++) {
        if (result[i] != null) {
          Map<String, dynamic> map = result[i];
          _listChapter.add(Chapter.fromJson(map));
        }
      }
    }
    listChapter = _listChapter;
    return listChapter;
  }

  List<Chapter> getChapterByIdCatalogue(idCatalogue) {
    return listChapter
        .where((element) => element.idCatalogue == idCatalogue)
        .toList();
  }
}
