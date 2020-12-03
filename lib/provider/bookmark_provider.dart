import 'package:bei/model/bookmark.dart';
import 'package:flutter/material.dart';

class BookmarkProvider extends ChangeNotifier {
  List<Bookmark> _listBookmark = List<Bookmark>();

  set listBookmark(List<Bookmark> listBookmark) {
    _listBookmark = listBookmark;
    notifyListeners();
  }

  List<Bookmark> get listBookmark => _listBookmark;

  List<Bookmark> getAll() {
    return listBookmark;
  }

  // Future<List<User>> fecthAll() async {
  //   _listBookmark = List<User>();
  //   final response = await http.get(Constanta.GET_USERS);
  //   Map<String, dynamic> map = json.decode(response.body);
  //   List<dynamic> result = map['result'];
  //   if (result.length > 0) {
  //     for (int i = 0; i < result.length; i++) {
  //       if (result[i] != null) {
  //         Map<String, dynamic> map = result[i];
  //         _listBookmark.add(User.fromJson(map));
  //         if (result[i]['id'] == 413) {
  //           currentUser = User.fromJson(map);
  //         }
  //       }
  //     }
  //   }
  //   listUser = _listBookmark;
  //   return listUser;
  // }
}
