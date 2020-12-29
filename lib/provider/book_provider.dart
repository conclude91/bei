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
  String _bookType = 'All';

  set bookType(String bookType) {
    _bookType = bookType;
    notifyListeners();
  }

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
  String get bookType => _bookType;

  List<Book> getAll() {
    return listBook;
  }

  List<String> getAllBookType() {
    List<String> listBookType =
        listBook.map<String>((row) => row.bookType).toSet().toList();
    listBookType.add('All');
    listBookType.sort();
    return listBookType;
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
    return listBook
        .where((element) => level != 'All' ? element.level == level : true)
        .where((element) => group != 'All' ? element.group == group : true)
        .where(
            (element) => subject != 'All' ? element.subject == subject : true)
        .where((element) =>
            bookType != 'All' ? element.bookType == bookType : true)
        .toList();
  }

  List<Book> getAnotherBookByLevelGroup(level, group) {
    return listBook
        .where((element) => element.level == level && element.group == group)
        .take(10)
        .toList();
  }

  Future<List<Book>> fetchAll() async {
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

  Future<List<Book>> fetchPopular() async {
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
