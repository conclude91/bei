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
import 'package:filesize/filesize.dart';
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
      builder: (context, bookProvider, languageProvider, _) => WillPopScope(
        onWillPop: isDownloading ? showCancelDownload : null,
        child: Scaffold(
          body: Container(
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
                              isDownloading
                                  ? showCancelDownload()
                                  : Navigator.pop(context);
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
                                Icons.announcement_outlined,
                                color: isDownloading
                                    ? disableColor
                                    : primaryTextColor,
                              ),
                            ),
                            onTap: () {
                              if (isDownloading == false)
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CustomText(
                                    text: widget.book.title,
                                    size: normal,
                                    maxLine: 3,
                                  ),
                                  CustomText(
                                    text: languageProvider.language
                                        ? enWriter + ' :\n' + widget.book.writer
                                        : inaWriter +
                                            ' :\n' +
                                            widget.book.writer,
                                    size: small,
                                    maxLine: 3,
                                  ),
                                  CustomText(
                                    text: widget.book.description,
                                    size: tiny,
                                    maxLine: 5,
                                  ),
                                  FlatButton(
                                    color: isDownloading
                                        ? disableColor
                                        : primaryColor,
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
                                        color: isDownloading
                                            ? disableColor
                                            : primaryColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (isDownloading == false) {
                                        readBook();
                                      }
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
                        height: 225,
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
                                if (isDownloading == false)
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookDetailPage(
                                        book: bookProvider
                                            .getAnotherBookByLevelGroup(
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
              titleChapter: languageProvider.language
                  ? '[' + enFullBook + '] : ' + widget.book.title
                  : '[' + inaFullBook + '] : ' + widget.book.title,
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
                            text: languageProvider.language
                                ? enNoData
                                : inaNoData,
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
                                      color: primaryTextColor,
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
                                    FutureBuilder<Widget>(
                                      future: showInfo(listChapter[index]),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<Widget> snapshot) {
                                        if (snapshot.data != null) {
                                          return snapshot.data;
                                        } else {
                                          return SizedBox();
                                        }
                                      },
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
                                int origin = await getFileSize(
                                    listChapter[index].attachment);
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
                                      listChapter[index].titleCatalogue,
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

  showAlertDownload(titleCatalogue, titleChapter, filename, attachment) {
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
                ? enNotifDownload + ' $titleChapter ?'
                : inaNotifDownload + ' $titleChapter ?',
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
                  titleCatalogue,
                  titleChapter,
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

  downloadFile(titleCatalogue, titleChapter, filename, attachment, int idUser,
      int idCatalogue) async {
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookRead(
              titleCatalogue: titleCatalogue,
              titleChapter: titleChapter,
              filePath: '${dir.path}/${widget.book.id}/$filename.pdf',
            ),
          ),
        );
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

  bool checkStatusDownloaded(Chapter chapter, origin, local) {
    bool result = false;
    if (listFile.length > 0) {
      for (int i = 0; i < listFile.length; i++) {
        String filename =
            listFile[i].toString().split("/").last.replaceAll("'", "");
        String tempIdDetail = filename.substring(0, filename.indexOf('.'));
        if (tempIdDetail == chapter.idDetail && origin == local) {
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
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
        );
      } else {
        print(response.reasonPhrase);
        Fluttertoast.showToast(
          msg: Provider.of<LanguageProvider>(context, listen: false).language
              ? enFailedDownload
              : inaFailedDownload,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
        );
      }
    });
  }

  Future<int> getFileSize(String url) async {
    http.Response r = await http.head(url);
    int origin = int.parse(r.headers['content-length']);
    return origin;
  }

  Future<Widget> showInfo(Chapter chapter) async {
    var dir = await getExternalStorageDirectory();
    String filePath = '${dir.path}/${widget.book.id.toString()}/' +
        chapter.idDetail.toString() +
        '.pdf';
    int origin = await getFileSize(chapter.attachment);
    int local = await File(filePath).exists() ? File(filePath).lengthSync() : 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          checkStatusDownloaded(chapter, origin, local)
              ? Icons.download_done_outlined
              : Icons.download_outlined,
          color: checkStatusDownloaded(chapter, origin, local)
              ? Colors.green
              : primaryTextColor,
          size: 20,
        ),
        SizedBox(
          height: paddingMicro,
        ),
        CustomText(
          text: filesize(origin),
          size: tiny,
          color: primaryTextColor,
        )
      ],
    );
  }

  Future<bool> showCancelDownload() async {
    return (await showDialog(
            context: context,
            builder: (_) => Consumer<LanguageProvider>(
                  builder: (context, languageProvider, _) => AlertDialog(
                    title: CustomText(
                      text: languageProvider.language
                          ? enDownloading
                          : inaDownloading,
                      size: regular,
                      color: primaryColor,
                    ),
                    content: CustomText(
                      text: languageProvider.language
                          ? enNotifCancelDownload
                          : inaNotifCancelDownload,
                      maxLine: 2,
                      size: normal,
                    ),
                    actions: <Widget>[
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
                        },
                      ),
                    ],
                  ),
                )) ??
        false);
  }
}
