import 'dart:convert';

import 'package:bei/consts/constanta.dart';
import 'package:bei/model/chapter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChapterProvider extends ChangeNotifier {
  List<Chapter> _chapters = new List<Chapter>();
  int _idCatalogue = 0;

  List<Chapter> get listChapter => _chapters;
  int get idCatalogue => _idCatalogue;

  set idCatalogue(int value) {
    _idCatalogue = value;
    notifyListeners();
  }

  set listChapter(List<Chapter> chapters) {
    this._chapters = chapters;
    notifyListeners();
  }

  Future<List<Chapter>> fecthData() async {
    final response = await http.get(Constanta.GET_BOOKS);
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> result = map['result'];
    if (result.length > 0) {
      if (result.length > 0) {
        for (int i = 0; i < result.length; i++) {
          if (result[i] != null) {
            Map<String, dynamic> map = result[i];
            _chapters.add(Chapter.fromJson(map));
          }
        }
      }
    }
    listChapter = _chapters;
    return listChapter;
  }

  List<Chapter> get getChapterByIdCatalogue => listChapter
      .where((element) => element.idCatalogue == idCatalogue)
      .toList();

  List<Chapter> getAll() {
    return listChapter;
  }
}
