import 'package:flutter/cupertino.dart';

class Bookmark {
  String titleCatalogue;
  String titleChapter;
  String filePath;
  int page;

  Bookmark({
    @required this.titleCatalogue,
    @required this.titleChapter,
    @required this.filePath,
    @required this.page,
  });

  Map<String, dynamic> toJson() => {
        'titleCatalogue': titleCatalogue,
        'titleChapter': titleChapter,
        'filePath': filePath,
        'page': page,
      };

  Bookmark.fromJson(Map<String, dynamic> json)
      : titleCatalogue = json['titleCatalogue'],
        titleChapter = json['titleChapter'],
        filePath = json['filePath'],
        page = json['page'];
}
