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
}
