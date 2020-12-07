import 'dart:io';
import 'dart:io' as io;

import 'package:bei/consts/constanta.dart';
import 'package:bei/model/book.dart';
import 'package:bei/model/chapter.dart';
import 'package:bei/pages/book_read.dart';
import 'package:bei/pages/book_report.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/provider/chapter_provider.dart';
import 'package:bei/provider/language_provider.dart';
import 'package:bei/provider/user_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/card_book_gallery.dart';
import 'package:bei/widgets/card_book_thumbnail.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;

  BookDetailPage({
    @required this.book,
  });

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  String downloadProgress = '0%';
  bool isDownloading = false;
  double percentage = 0;
  List listFile = List();

  @override
  void initState() {
    super.initState();
    getListFile(widget.book.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<BookProvider, LanguageProvider>(
      builder: (context, bookProvider, languageProvider, _) => Scaffold(
        body: Container(
          color: backgroundColor,
          height: double.infinity,
          padding: EdgeInsets.only(
            top: paddingNormal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: appBarHeight,
                color: backgroundColor,
                child: Material(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
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
                      CustomText(
                        text: languageProvider.language
                            ? enBookDetail
                            : inaBookDetail,
                        size: regular,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: paddingTiny,
                          right: paddingTiny,
                        ),
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(paddingTiny),
                            child: Icon(
                              Icons.report_outlined,
                              color: primaryLevelColor,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookReport(
                                  book: widget.book,
                                ),
                              ),
                            );
                          },
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
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(
                    top: 0,
                  ),
                  children: [
                    Container(
                      height: 210,
                      padding: EdgeInsets.only(
                        top: paddingTiny,
                        bottom: paddingTiny,
                        left: paddingSmall,
                        right: paddingSmall,
                      ),
                      child: Stack(
                        children: [
                          CardBookGallery(
                            book: widget.book,
                          ),
                          Container(
                            height: double.infinity,
                            margin: EdgeInsets.only(
                              left: 130 + tiny,
                            ),
                            padding: EdgeInsets.only(
                              top: paddingTiny,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomText(
                                  text: widget.book.title,
                                  size: normal,
                                  maxLine: 3,
                                ),
                                CustomText(
                                  text: widget.book.writer,
                                  size: small,
                                  maxLine: 3,
                                ),
                                FlatButton(
                                  color: primaryColor,
                                  child: CustomText(
                                    text: languageProvider.language
                                        ? enRead
                                        : inaRead,
                                    size: small,
                                    color: secondaryTextColor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      radiusNormal,
                                    ),
                                    side: BorderSide(
                                      color: primaryColor,
                                    ),
                                  ),
                                  onPressed: () {
                                    readBook();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: (isDownloading) ? true : false,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Column(
                          children: [
                            CustomText(
                                text: languageProvider.language
                                    ? enDownloading + ' : $downloadProgress'
                                    : inaDownloading + ' : $downloadProgress',
                                size: tiny),
                            SizedBox(
                              height: 5,
                            ),
                            LinearProgressIndicator(
                              minHeight: 2,
                              value: percentage,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: paddingSmall,
                    ),
                    Container(
                      height: 250,
                      padding: EdgeInsets.only(
                        left: paddingSmall,
                        right: paddingSmall,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomText(
                            text: languageProvider.language
                                ? enBookDescription
                                : inaBookDescription,
                            size: normal,
                          ),
                          Divider(
                            color: primaryColor,
                          ),
                          CustomText(
                            text: widget.book.description,
                            size: small,
                            maxLine: 10,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: paddingSmall,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: paddingSmall,
                        right: paddingSmall,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomText(
                            text: languageProvider.language
                                ? enAnotherBook
                                : inaAnotherBook,
                            size: normal,
                          ),
                          Divider(
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 246,
                      padding: EdgeInsets.only(
                        top: paddingTiny,
                        bottom: paddingTiny,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(
                          top: 0,
                        ),
                        itemCount: bookProvider
                            .getAnotherBookByLevelGroup(
                                widget.book.level, widget.book.group)
                            .length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(
                                left: index == 0 ? paddingSmall - 3 : 0,
                                right: index ==
                                        bookProvider
                                                .getAnotherBookByLevelGroup(
                                                    widget.book.level,
                                                    widget.book.group)
                                                .length -
                                            1
                                    ? paddingSmall - 3
                                    : 0,
                              ),
                              child: CardBookThumbnail(
                                book: bookProvider.getAnotherBookByLevelGroup(
                                    widget.book.level,
                                    widget.book.group)[index],
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetailPage(
                                    book:
                                        bookProvider.getAnotherBookByLevelGroup(
                                            widget.book.level,
                                            widget.book.group)[index],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  readBook() {
    getListFile(widget.book.id);
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusRegular),
          topRight: Radius.circular(radiusRegular),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (builder) {
        return Consumer3<ChapterProvider, BookProvider, LanguageProvider>(
            builder:
                (context, chapterProvider, bookProvider, languageProvider, _) {
          List<Chapter> listChapter =
              chapterProvider.getChapterByIdCatalogue(widget.book.id);
          listChapter.add(
            Chapter(
              attachment: widget.book.attachment,
              titleChapter: widget.book.title,
              titleCatalogue: widget.book.title,
              idDetail: widget.book.id.toString(),
              idCatalogue: widget.book.id,
              audio: '',
            ),
          );
          listChapter.sort((a, b) {
            return a.idDetail.toLowerCase().compareTo(b.idDetail.toLowerCase());
          });

          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: paddingTiny,
                    bottom: paddingTiny,
                    left: paddingSmall,
                  ),
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusRegular),
                      topRight: Radius.circular(radiusRegular),
                    ),
                    color: primaryColor,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: languageProvider.language
                          ? enListContent
                          : inaListContent,
                      size: normal,
                      color: secondaryTextColor,
                    ),
                  ),
                ),
                Expanded(
                  child: (listChapter.isEmpty)
                      ? Center(
                          child: CustomText(
                            text: 'No data found',
                            size: normal,
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: listChapter.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                padding: EdgeInsets.only(
                                  left: paddingSmall,
                                  right: paddingSmall,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.picture_as_pdf_outlined,
                                      color: Colors.redAccent,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: paddingSmall,
                                    ),
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: CustomText(
                                          text: listChapter[index].titleChapter,
                                          size: normal,
                                          maxLine: 1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: paddingSmall,
                                    ),
                                    Icon(
                                      checkStatusDownloaded(
                                              listChapter[index].idDetail)
                                          ? Icons.download_done_outlined
                                          : Icons.download_outlined,
                                      color: checkStatusDownloaded(
                                              listChapter[index].idDetail)
                                          ? Colors.green
                                          : primaryTextColor,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () async {
                                var dir = await getExternalStorageDirectory();
                                String filePath =
                                    '${dir.path}/${widget.book.id.toString()}/' +
                                        listChapter[index].idDetail.toString() +
                                        '.pdf';
                                http.Response r = await http
                                    .head(listChapter[index].attachment);
                                int origin =
                                    int.parse(r.headers['content-length']);
                                int local = await File(filePath).exists()
                                    ? File(filePath).lengthSync()
                                    : 0;
                                if (local == origin) {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookRead(
                                        titleCatalogue:
                                            listChapter[index].titleCatalogue,
                                        titleChapter:
                                            listChapter[index].titleChapter,
                                        filePath: filePath,
                                      ),
                                    ),
                                  );
                                } else {
                                  showAlertDownload(
                                      listChapter[index].titleChapter,
                                      listChapter[index].idDetail,
                                      listChapter[index].attachment);
                                }
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 1,
                              color: disableTextColor,
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  showText(List<Chapter> listChapter) {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < listChapter.length; i++) {
      if (listChapter[i].idCatalogue == 338) {
        list.add(Text('Hello'));
      } else {
        list.add(Text('Nay'));
      }
    }
    return ListView(children: list);
  }

  showAlertDownload(title, filename, attachment) {
    showDialog(
      context: context,
      builder: (_) => Consumer2<UserProvider, LanguageProvider>(
        builder: (context, userProvider, languageProvider, _) => AlertDialog(
          title: CustomText(
            text: languageProvider.language ? enDownload : inaDownload,
            size: regular,
            color: primaryColor,
          ),
          content: CustomText(
            text: languageProvider.language
                ? enNotifDownload + ' $title ?'
                : inaNotifDownload + ' $title ?',
            maxLine: 2,
            size: normal,
          ),
          actions: [
            FlatButton(
              child: CustomText(
                text: languageProvider.language ? enNo : inaNo,
                size: normal,
                color: primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: CustomText(
                text: languageProvider.language ? enYes : inaYes,
                size: normal,
                color: primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                downloadFile(
                  filename,
                  attachment,
                  userProvider.currentUser.id,
                  widget.book.id,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  downloadFile(filename, attachment, int idUser, int idCatalogue) async {
    setState(() {
      isDownloading = !isDownloading;
    });

    var dir = await getExternalStorageDirectory();
    Dio dio = Dio();
    dio.download(attachment, '${dir.path}/${widget.book.id}/$filename.pdf',
        onReceiveProgress: (actualbytes, totalbytes) {
      var tempPercentage = actualbytes / totalbytes * 100;
      if (tempPercentage < 100) {
        percentage = tempPercentage / 100;
        setState(() {
          downloadProgress = '${tempPercentage.floor()}%';
        });
      } else {
        setState(() {
          isDownloading = !isDownloading;
        });
      }
    }).then(
      (value) => updateDownloadBook(idUser, idCatalogue),
    );
  }

  getListFile(idCatalogue) async {
    var directory = (await getExternalStorageDirectory()).path;
    if (await io.Directory(directory.toString() + '/$idCatalogue').exists()) {
      setState(() {
        listFile =
            io.Directory(directory.toString() + '/$idCatalogue').listSync();
      });
    }
  }

  bool checkStatusDownloaded(idDetail) {
    bool result = false;
    if (listFile.length > 0) {
      for (int i = 0; i < listFile.length; i++) {
        String filename =
            listFile[i].toString().split("/").last.replaceAll("'", "");
        String tempIdDetail = filename.substring(0, filename.indexOf('.'));
        if (tempIdDetail == idDetail) {
          result = true;
        }
      }
    }
    return result;
  }

  updateDownloadBook(int idUser, int idCatalogue) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(Constanta.UPDATE_DOWNLOAD_BOOK));
    request.fields.addAll({
      'id_user': idUser.toString(),
      'id_catalogue': idCatalogue.toString(),
    });
    await request.send().then((response) {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: Provider.of<LanguageProvider>(context, listen: false).language
              ? enSuccessDownload
              : inaSuccessDownload,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        print(response.reasonPhrase);
        Fluttertoast.showToast(
          msg: Provider.of<LanguageProvider>(context, listen: false).language
              ? enFailedDownload
              : inaFailedDownload,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    });
  }
}
