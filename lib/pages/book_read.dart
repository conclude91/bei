import 'dart:io';

import 'package:bei/model/bookmark.dart';
import 'package:bei/model/chapter.dart';
import 'package:bei/provider/bookmark_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
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
    return Consumer<BookmarkProvider>(
      builder: (context, bookmarkProvider, _) => Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            top: paddingNormal,
          ),
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
                          text: widget.titleChapter,
                          size: regular,
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
                                Icons.bookmark_outline,
                              ),
                            ),
                            onTap: () {
                              bookmarkProvider.listBookmark.add(
                                Bookmark(
                                  titleCatalogue: widget.titleCatalogue,
                                  titleChapter: widget.titleChapter,
                                  filePath: widget.filePath,
                                  page: pdfViewerController.pageNumber,
                                ),
                              );
                              Fluttertoast.showToast(
                                msg: 'Bookmark has been added',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
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
