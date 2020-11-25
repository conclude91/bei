import 'dart:convert';

import 'package:bei/consts/constanta.dart';
import 'package:bei/model/chapter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChapterProvider extends ChangeNotifier {
  List<Chapter> _listChapter = new List<Chapter>();

  List<Chapter> get listChapter => _listChapter;

  set listChapter(List<Chapter> listChapter) {
    _listChapter = listChapter;
    notifyListeners();
  }

  Future<List<Chapter>> fecthData() async {
    _listChapter = new List<Chapter>();
    final response = await http.get(Constanta.GET_CHAPTERS);
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
    listChapter.sort((a, b) {
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });
    return listChapter
        .where((element) => element.idCatalogue == idCatalogue)
        .toList();
  }
}
