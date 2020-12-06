import 'dart:convert';
import 'package:bei/consts/constanta.dart';
import 'package:bei/model/book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookProvider extends ChangeNotifier {
  List<Book> _listBook = new List<Book>();
  List<Book> _listBookPopular = new List<Book>();
  String _level = 'All';
  String _group = 'All';
  String _subject = 'All';

  set level(String level) {
    _level = level;
    notifyListeners();
  }

  set group(String group) {
    _group = group;
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

  set listBookPopular(List<Book> listBook) {
    _listBookPopular = listBook;
    notifyListeners();
  }

  List<Book> get listBook => _listBook;
  List<Book> get listBookPopular => _listBookPopular;
  String get level => _level;
  String get group => _group;
  String get subject => _subject;

  List<Book> getAll() {
    return listBook;
  }

  List<String> getAllLevel() {
    List<String> listLevel =
        listBook.map<String>((row) => row.level).toSet().toList();
    listLevel.add('All');
    listLevel.sort();
    return listLevel;
  }

  List<String> getAllClass() {
    List<String> listClass = new List<String>();
    level != 'All'
        ? listClass = listBook
            .where((element) => element.level == level)
            .map<String>((row) => row.group)
            .toSet()
            .toList()
        : listClass = listBook.map<String>((row) => row.group).toSet().toList();
    listClass.add('All');
    listClass.sort((b, a) => a.compareTo(b));
    return listClass;
  }

  List<String> getAllSubject() {
    List<String> listSubject = new List<String>();
    level != 'All'
        ? group != 'All'
            ? listSubject = listBook
                .where((element) =>
                    element.level == level && element.group == group)
                .map<String>((row) => row.subject)
                .toSet()
                .toList()
            : listSubject = listBook
                .where((element) => element.level == level)
                .map<String>((row) => row.subject)
                .toSet()
                .toList()
        : listSubject =
            listBook.map<String>((row) => row.subject).toSet().toList();
    listSubject.add('All');
    listSubject.sort();
    return listSubject;
  }

  List<Book> getRecent() {
    return level != 'All'
        ? listBook.where((element) => element.level == level).take(10).toList()
        : listBook.take(10).toList();
  }

  List<Book> getPopular() {
    return level != 'All'
        ? listBookPopular
            .where((element) => element.level == level)
            .take(10)
            .toList()
        : listBookPopular.take(10).toList();
  }

  List<Book> getFiltered() {
    return level != 'All'
        ? group != 'All'
            ? subject != 'All'
                ? listBook
                    .where((element) =>
                        element.level == level &&
                        element.group == group &&
                        element.subject == subject)
                    .toList()
                : listBook
                    .where((element) =>
                        element.level == level && element.group == group)
                    .toList()
            : subject != 'All'
                ? listBook
                    .where((element) =>
                        element.level == level && element.subject == subject)
                    .toList()
                : listBook.where((element) => element.level == level).toList()
        : group != 'All'
            ? subject != 'All'
                ? listBook.where((element) =>
                    element.group == group && element.subject == subject)
                : listBook.where((element) => element.group == group).toList()
            : subject != 'All'
                ? listBook
                    .where((element) => element.subject == subject)
                    .toList()
                : listBook.toList();
  }

  List<Book> getAnotherBookByLevelGroup(level, group) {
    return listBook
        .where((element) => element.level == level && element.group == group)
        .take(10)
        .toList();
  }

  Future<List<Book>> fecthAll() async {
    _listBook = new List<Book>();
    final response = await http.get(Constanta.GET_BOOKS);
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> result = map['result'];
    if (result.length > 0) {
      for (int i = 0; i < result.length; i++) {
        if (result[i] != null) {
          Map<String, dynamic> map = result[i];
          if (result[i]['type'] == 'pdf') {
            _listBook.add(Book.fromJson(map));
          }
        }
      }
    }
    listBook = _listBook;
    return listBook;
  }

  Future<List<Book>> fecthPopular() async {
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
}
