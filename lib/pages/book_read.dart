import 'dart:convert';
import 'dart:io';

import 'package:bei/model/bookmark.dart';
import 'package:bei/provider/bookmark_provider.dart';
import 'package:bei/provider/language_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BookRead extends StatefulWidget {
  final String filePath;
  final int pageNumber;
  final String titleChapter;
  final String titleCatalogue;

  BookRead({
    @required this.filePath,
    @required this.titleChapter,
    @required this.titleCatalogue,
    this.pageNumber,
  });

  @override
  _BookReadState createState() => _BookReadState();
}

class _BookReadState extends State<BookRead> {
  GlobalKey<SfPdfViewerState> pdfViewerKey;
  PdfViewerController pdfViewerController;

  @override
  void initState() {
    pdfViewerKey = GlobalKey();
    pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<BookmarkProvider, LanguageProvider>(
      builder: (context, bookmarkProvider, languageProvider, _) => Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: appBarHeight,
                color: backgroundColor,
                child: Stack(
                  children: [
                    (Platform.isIOS)
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(
                                left: paddingTiny,
                              ),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios_outlined,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      languageProvider.language
                                          ? enBack
                                          : inaBack,
                                      style: TextStyle(
                                        fontSize: normal,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          )
                        : Align(
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: paddingTiny,
                          right: paddingTiny + 50,
                        ),
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(paddingTiny),
                            child: Icon(
                              Icons.bookmark_outline,
                              color: (Platform.isIOS)
                                  ? Colors.blue
                                  : primaryTextColor,
                            ),
                          ),
                          onTap: () async {
                            bookmarkProvider.listBookmark.add(
                              Bookmark(
                                titleCatalogue: widget.titleCatalogue,
                                titleChapter: widget.titleChapter,
                                filePath: widget.filePath,
                                page: pdfViewerController.pageNumber,
                              ),
                            );
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setString(
                              'listBookmark',
                              json.encode(bookmarkProvider.listBookmark),
                            );
                            Fluttertoast.showToast(
                              msg: languageProvider.language
                                  ? enSuccessBookmark
                                  : inaSuccessBookmark,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: paddingTiny,
                          right: paddingTiny,
                        ),
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(paddingTiny),
                            child: Icon(
                              Icons.local_print_shop_outlined,
                              color: (Platform.isIOS)
                                  ? Colors.blue
                                  : primaryTextColor,
                            ),
                          ),
                          onTap: () async {
                            await Printing.layoutPdf(
                              onLayout: (_) =>
                                  File(widget.filePath).readAsBytesSync(),
                              name: widget.titleChapter,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: primaryColor,
              ),
              Expanded(
                child: SfPdfViewer.file(
                  File(widget.filePath),
                  key: pdfViewerKey,
                  controller: pdfViewerController,
                  onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                    if (widget.pageNumber != null) {
                      pdfViewerController.jumpToPage(widget.pageNumber);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
