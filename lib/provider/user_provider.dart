import 'dart:convert';

import 'package:bei/consts/constanta.dart';
import 'package:bei/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  List<User> _listUser = [];
  User _currentuser = User();

  set listUser(List<User> listUser) {
    _listUser = listUser;
    notifyListeners();
  }

  set currentUser(User user) {
    _currentuser = user;
    notifyListeners();
  }

  List<User> get listUser => _listUser;
  User get currentUser => _currentuser;

  List<User> getAll() {
    return listUser;
  }

  Future<List<User>> fetchAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _listUser = [];
    final response = await http.get(Uri.parse(Constanta.GET_USERS));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> result = map['result'];
    if (result.length > 0) {
      for (int i = 0; i < result.length; i++) {
        if (result[i] != null) {
          Map<String, dynamic> map = result[i];
          _listUser.add(User.fromJson(map));
          if (result[i]['email'] == prefs.getString('email')) {
            currentUser = User.fromJson(map);
          }
        }
      }
    }
    listUser = _listUser;
    return listUser;
  }
}
