import 'package:bei/pages/book_read.dart';
import 'package:bei/provider/bookmark_provider.dart';
import 'package:bei/provider/language_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<BookmarkProvider, LanguageProvider>(
      builder: (context, bookmarkProvider, languageProvider, _) => Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            top: paddingNormal,
          ),
          color: backgroundColor,
          child: Material(
            child: Column(
              children: [
                Container(
                  height: appBarHeight,
                  color: backgroundColor,
                  child: Material(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                              left: paddingTiny,
                              right: paddingTiny,
                            ),
                            child: InkWell(
                              child: Padding(
                                padding: EdgeInsets.all(paddingTiny),
                                child: Icon(
                                  Icons.arrow_back,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Center(
                          child: CustomText(
                            text: languageProvider.language
                                ? enBookmarkList
                                : inaBookmarkList,
                            size: regular,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: primaryColor,
                  height: 1,
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(
                      top: 0,
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: bookmarkProvider.listBookmark.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                            right: 5,
                          ),
                          child: ListTile(
                            title: CustomText(
                              text: bookmarkProvider
                                  .listBookmark[index].titleCatalogue,
                              color: primaryTextColor,
                              size: normal,
                            ),
                            subtitle: CustomText(
                              text: languageProvider.language
                                  ? bookmarkProvider
                                          .listBookmark[index].titleChapter +
                                      ' [' +
                                      enPage +
                                      ' ' +
                                      bookmarkProvider.listBookmark[index].page
                                          .toString() +
                                      ']'
                                  : bookmarkProvider
                                          .listBookmark[index].titleChapter +
                                      ' [' +
                                      inaPage +
                                      ' ' +
                                      bookmarkProvider.listBookmark[index].page
                                          .toString() +
                                      ']',
                              color: Colors.black54,
                              size: small,
                            ),
                            dense: true,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookRead(
                                titleCatalogue: bookmarkProvider
                                    .listBookmark[index].titleCatalogue,
                                titleChapter: bookmarkProvider
                                    .listBookmark[index].titleChapter,
                                filePath: bookmarkProvider
                                    .listBookmark[index].filePath,
                                pageNumber:
                                    bookmarkProvider.listBookmark[index].page,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                        color: primaryTextColor,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
