import 'dart:convert';

import 'package:bei/consts/constanta.dart';
import 'package:bei/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  List<User> _listUser = List<User>();
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

  Future<List<User>> fecthAll() async {
    _listUser = List<User>();
    final response = await http.get(Constanta.GET_USERS);
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> result = map['result'];
    if (result.length > 0) {
      for (int i = 0; i < result.length; i++) {
        if (result[i] != null) {
          Map<String, dynamic> map = result[i];
          _listUser.add(User.fromJson(map));
          if (result[i]['id'] == 413) {
            currentUser = User.fromJson(map);
          }
        }
      }
    }
    listUser = _listUser;
    return listUser;
  }
}
