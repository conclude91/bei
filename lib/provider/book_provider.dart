import 'dart:convert';
import 'package:bei/consts/constanta.dart';
import 'package:bei/model/book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookProvider extends ChangeNotifier {
  List<Book> _listBook = new List<Book>();
  List<Book> _listBookPopular = new List<Book>();
  String _level = 'All';
  String _subject = 'All';
  bool _isSwitch = false;

  List<Book> get listBook => _listBook;
  List<Book> get listBookPopular => _listBookPopular;
  String get level => _level;
  String get subject => _subject;
  bool get isSwitch => _isSwitch;

  set isSwitch(bool isSwitch) {
    _isSwitch = isSwitch;
    notifyListeners();
  }

  set level(String level) {
    _level = level;
    notifyListeners();
  }

  set subject(String subject) {
    _subject = subject;
    notifyListeners();
  }

  set listBook(List<Book> listBook) {
    _listBook = listBook;
    notifyListeners();
  }

  set listBookPopular(List<Book> listBookPopular) {
    _listBookPopular = listBookPopular;
    notifyListeners();
  }

  Future<List<Book>> fecthData() async {
    _listBook = new List<Book>();
    final response = await http.get(Constanta.GET_BOOKS);
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> result = map['result'];
    if (result.length > 0) {
      for (int i = 0; i < result.length; i++) {
        if (result[i] != null) {
          Map<String, dynamic> map = result[i];
          _listBook.add(Book.fromJson(map));
        }
      }
    }
    listBook = _listBook;
    return listBook;
  }

  Future<List<Book>> fetchDataPopular() async {
    _listBookPopular = new List<Book>();
    final response = await http.get(Constanta.GET_BOOKS_POPULAR);
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> result = map['result'];
    if (result.length > 0) {
      for (int i = 0; i < result.length; i++) {
        if (result[i] != null) {
          Map<String, dynamic> map = result[i];
          _listBookPopular.add(Book.fromJson(map));
        }
      }
    }
    listBookPopular = _listBookPopular;
    return listBookPopular;
  }

  List<Book> getAll() {
    return listBook;
  }

  List<String> getAllLevel() {
    List<String> listLevel =
        listBook.map<String>((row) => row.level).toSet().toList();
    listLevel.add('All');
    return listLevel;
  }

  List<String> getAllSubject() {
    List<String> listSubject =
        listBook.map<String>((row) => row.subject).toSet().toList();
    listSubject.add('All');
    return listSubject;
  }

  List<Book> getPopular() {
    return (listBookPopular.length < 10)
        ? listBookPopular.take(listBookPopular.length).toList()
        : listBookPopular.take(10).toList();
  }

  List<Book> get getRecentByLevel => (level != 'All')
      ? listBook.where((element) => element.level == level).take(5).toList()
      : listBook.take(5).toList();

  List<Book> get getRecentAll => listBook.take(10).toList();

  List<String> getByLevelSubject() {
    List<String> listLevel =
        listBook.map<String>((row) => row.level).toSet().toList();
    listLevel.add('All');
    return listLevel;
  }

  List<Book> getFiltered() {
    return (level != 'All')
        ? (subject != 'All')
            ? listBook
                .where((element) =>
                    element.level == level && element.subject == subject)
                .toList()
            : listBook.where((element) => element.level == level).toList()
        : (subject != 'All')
            ? listBook.where((element) => element.subject == subject).toList()
            : listBook.toList();
  }

  List<Book> getAnotherBookByWriter(int id, String writer) {
    return listBook
        .where((element) => element.writer == writer && element.id != id)
        .toList();
  }

  List<Book> getSampleByLevel(String level) {
    return listBook
        .where((element) => element.level == level)
        .take(10)
        .toList();
  }
}
