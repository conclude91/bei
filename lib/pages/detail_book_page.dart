import 'dart:convert';
import 'dart:io';

import 'package:bei/model/book.dart';
import 'package:bei/pages/read_book.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/provider/chapter_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/card_book_gallery.dart';
import 'package:bei/widgets/card_book_list.dart';
import 'package:bei/widgets/primary_text.dart';
import 'package:bei/widgets/secondary_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class DetailBookPage extends StatefulWidget {
  final Book book;

  DetailBookPage({this.book});

  @override
  _DetailBookPageState createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  String downloadProgress = '0%';
  bool isDownloading = false;
  double percentage = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, _) => Scaffold(
        body: Container(
          color: AppColor.backgroundColor,
          height: double.infinity,
          padding: EdgeInsets.only(
            top: AppDimen.paddingNormal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: AppDimen.appBarHeight,
                color: AppColor.backgroundColor,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(
                            top: AppDimen.paddingTiny,
                            bottom: AppDimen.tiny,
                            right: AppDimen.paddingSmall,
                            left: AppDimen.paddingSmall,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: PrimaryText(
                        text: bookProvider.isSwitch
                            ? 'Detail Buku'
                            : 'Book Detail',
                        size: AppDimen.regular,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(
                            top: AppDimen.paddingTiny,
                            bottom: AppDimen.tiny,
                            right: AppDimen.paddingSmall,
                            left: AppDimen.paddingSmall,
                          ),
                          margin: EdgeInsets.only(right: 35),
                          child: Icon(
                            Icons.report,
                          ),
                        ),
                        onTap: () {
                          createUser('hello@gmail.com');
                          // sendReport(
                          //     999, 364, 'Hello', 'deskripsi', '01290319230');
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(
                            top: AppDimen.paddingTiny,
                            bottom: AppDimen.tiny,
                            right: AppDimen.paddingSmall,
                            left: AppDimen.paddingSmall,
                          ),
                          child: Icon(
                            Icons.file_download,
                          ),
                        ),
                        onTap: () {
                          if (widget.book.type != 'interactive') {
                            showAlertDownload(
                              'Full Book',
                              widget.book.id,
                              widget.book.attachment,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: AppColor.primaryColor,
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
                        top: AppDimen.paddingTiny,
                        bottom: AppDimen.paddingTiny,
                        left: AppDimen.paddingSmall,
                        right: AppDimen.paddingSmall,
                      ),
                      child: Stack(
                        children: [
                          CardBookGallery(
                            book: widget.book,
                          ),
                          Container(
                            height: double.infinity,
                            margin: EdgeInsets.only(
                              left: 130 + AppDimen.tiny,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                PrimaryText(
                                  text: widget.book.title,
                                  size: AppDimen.regular,
                                  maxLine: 3,
                                ),
                                PrimaryText(
                                  text: widget.book.writer,
                                  size: AppDimen.normal,
                                  maxLine: 3,
                                ),
                                FlatButton(
                                  color: AppColor.primaryColor,
                                  child: SecondaryText(
                                    text: bookProvider.isSwitch
                                        ? 'Sub Bab'
                                        : 'Chapter',
                                    size: AppDimen.small,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppDimen.radiusNormal,
                                    ),
                                    side: BorderSide(
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                  onPressed: () {
                                    showChapter();
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
                          left: AppDimen.paddingSmall,
                          right: AppDimen.paddingSmall,
                        ),
                        child: Column(
                          children: [
                            PrimaryText(
                                text: 'Downloading : $downloadProgress',
                                size: AppDimen.tiny),
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
                      height: AppDimen.paddingSmall,
                    ),
                    Container(
                      height: 250,
                      padding: EdgeInsets.only(
                        left: AppDimen.paddingSmall,
                        right: AppDimen.paddingSmall,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          PrimaryText(
                            text: bookProvider.isSwitch
                                ? 'Deskripsi Buku'
                                : 'Book Description',
                            size: AppDimen.regular,
                          ),
                          Divider(
                            color: AppColor.primaryColor,
                          ),
                          PrimaryText(
                            text: widget.book.description,
                            size: AppDimen.normal,
                            maxLine: 10,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppDimen.paddingSmall,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: AppDimen.paddingSmall,
                        right: AppDimen.paddingSmall,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          PrimaryText(
                            text: bookProvider.isSwitch
                                ? 'Buku Lain Dari Penulis'
                                : 'More From Author',
                            size: AppDimen.regular,
                          ),
                          Divider(
                            color: AppColor.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                        top: 0,
                      ),
                      itemCount: bookProvider
                          .getAnotherBookByWriter(
                              widget.book.id, widget.book.writer)
                          .length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: CardBookList(
                            book: bookProvider.getAnotherBookByWriter(
                              widget.book.id,
                              widget.book.writer,
                            )[index],
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailBookPage(
                                  book: bookProvider.getAnotherBookByWriter(
                                      widget.book.id,
                                      widget.book.writer)[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(
                            left: AppDimen.paddingNormal,
                            right: AppDimen.paddingNormal,
                          ),
                          child: Divider(
                            color: AppColor.primaryColor,
                          ),
                        );
                      },
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

  showChapter() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimen.radiusRegular),
          topRight: Radius.circular(AppDimen.radiusRegular),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (builder) {
        return Consumer2<ChapterProvider, BookProvider>(
          builder: (context, chapterProvider, bookProvider, _) => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: AppDimen.paddingTiny,
                    bottom: AppDimen.paddingTiny,
                    left: AppDimen.paddingSmall,
                  ),
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppDimen.radiusRegular),
                      topRight: Radius.circular(AppDimen.radiusRegular),
                    ),
                    color: AppColor.primaryColor,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SecondaryText(
                      text: bookProvider.isSwitch
                          ? 'Isi Konten :'
                          : 'List Content : ',
                      size: AppDimen.normal,
                    ),
                  ),
                ),
                Expanded(
                  child: (chapterProvider
                          .getChapterByIdCatalogue(widget.book.id)
                          .isEmpty)
                      ? Center(
                          child: PrimaryText(
                            text: 'No data found',
                            size: AppDimen.normal,
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: chapterProvider
                              .getChapterByIdCatalogue(widget.book.id)
                              .length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Container(
                                height: 50,
                                padding: EdgeInsets.only(
                                  left: AppDimen.paddingSmall,
                                  right: AppDimen.paddingSmall,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.picture_as_pdf_outlined,
                                          color: Colors.redAccent,
                                        ),
                                        SizedBox(
                                          width: AppDimen.paddingNormal,
                                        ),
                                        PrimaryText(
                                          text: chapterProvider
                                              .getChapterByIdCatalogue(
                                                  widget.book.id)[index]
                                              .title,
                                          size: AppDimen.normal,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () async {
                                var dir = await getExternalStorageDirectory();
                                String savePath =
                                    '${dir.path}/${widget.book.id.toString()}/' +
                                        chapterProvider
                                            .getChapterByIdCatalogue(
                                                widget.book.id)[index]
                                            .idDetail
                                            .toString() +
                                        '.pdf';
                                if (await File(savePath).exists()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ReadBook(path: savePath),
                                    ),
                                  );
                                } else {
                                  showAlertDownload(
                                      chapterProvider
                                          .getChapterByIdCatalogue(
                                              widget.book.id)[index]
                                          .title,
                                      chapterProvider
                                          .getChapterByIdCatalogue(
                                              widget.book.id)[index]
                                          .idDetail,
                                      chapterProvider
                                          .getChapterByIdCatalogue(
                                              widget.book.id)[index]
                                          .attachment);
                                }
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 1,
                              color: AppColor.disableTextColor,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showAlertDownload(title, filename, attachment) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Download'),
        content: Text('Do you want to download this $title ?'),
        actions: [
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.pop(context);
              downloadFile(filename, attachment);
            },
          ),
        ],
      ),
    );
  }

  downloadFile(filename, attachment) async {
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
    });
  }

  void sendReport(
    int idUser,
    int idCataloque,
    String title,
    String description,
    String phone,
  ) async {
    http.post('http://sibi.cloudapp.web.id/api/laporan/create.php',
        body: json.encode({
          'id_user': idUser,
          'id_catalogue': idCataloque,
          'title': title,
          'description': description,
          'phone': phone,
        }));
  }

  void createUser(
    String email,
  ) async {
    http.post('http://sibi.cloudapp.web.id/api/user/login.php',
        body: json.encode({
          'email': email,
        }));
  }
}
