import 'dart:convert';
import 'package:bei/consts/constanta.dart';
import 'package:bei/model/book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookProvider extends ChangeNotifier {
  List<Book> _books = new List<Book>();
  String _level = 'All';

  List<Book> get listBook => _books;
  String get level => _level;

  set level(String value) {
    _level = value;
    notifyListeners();
  }

  set listBook(List<Book> books) {
    this._books = books;
    notifyListeners();
  }

  Future<List<Book>> fecthData() async {
    final response = await http.get(Constanta.GET_BOOKS);
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> result = map['result'];
    if (result.length > 0) {
      if (result.length > 0) {
        for (int i = 0; i < result.length; i++) {
          if (result[i] != null) {
            Map<String, dynamic> map = result[i];
            _books.add(Book.fromJson(map));
          }
        }
      }
    }
    listBook = _books;
    return listBook;
  }

  List<Book> get getRecentByLevel => (level != 'All')
      ? listBook.where((element) => element.level == level).take(5).toList()
      : listBook.take(5).toList();

  List<Book> get getRecentAll => listBook.take(10).toList();

  List<Book> getSampleByLevel(String level) {
    return listBook
        .where((element) => element.level == level)
        .take(10)
        .toList();
  }

  List<Book> getAllByLevel(String level) {
    return listBook.where((element) => element.level == level).toList();
  }

  List<Book> getAnotherBookByWriter(int id, String writer) {
    return listBook
        .where((element) => element.writer == writer && element.id != id)
        .toList();
  }

  List<Book> getAll() {
    return listBook;
  }
}
