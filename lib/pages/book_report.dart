import 'dart:io';

import 'package:bei/consts/constanta.dart';
import 'package:bei/model/book.dart';
import 'package:bei/provider/language_provider.dart';
import 'package:bei/provider/user_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/card_book_gallery.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BookReport extends StatefulWidget {
  final Book book;

  BookReport({@required this.book});

  @override
  _BookReportState createState() => _BookReportState();
}

class _BookReportState extends State<BookReport> {
  TextEditingController titleController;
  TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, LanguageProvider>(
      builder: (context, userProvider, languageProvider, _) => Scaffold(
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
                    Center(
                      child: CustomText(
                        text: languageProvider.language
                            ? enBookReport
                            : inaBookReport,
                        size: regular,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: primaryColor,
                height: 1,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 0),
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
                            padding: EdgeInsets.only(
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            margin: EdgeInsets.only(
                              left: 130 + tiny,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomText(
                                  text: widget.book.title,
                                  size: normal,
                                  maxLine: 2,
                                ),
                                CustomText(
                                  text: languageProvider.language
                                      ? enWriter + ' :\n' + widget.book.writer
                                      : inaWriter + ' :\n' + widget.book.writer,
                                  size: small,
                                  maxLine: 3,
                                ),
                                CustomText(
                                  text: widget.book.description,
                                  size: tiny,
                                  maxLine: 7,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: paddingSmall,
                        right: paddingSmall,
                      ),
                      child: Divider(
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: paddingSmall,
                        right: paddingSmall,
                        top: paddingTiny,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomText(
                            text: languageProvider.language
                                ? enReportData
                                : inaReportData,
                            color: primaryTextColor,
                            size: normal,
                          ),
                          SizedBox(
                            height: paddingSmall,
                          ),
                          TextField(
                            controller: titleController,
                            autofocus: false,
                            style: TextStyle(
                              fontSize: small,
                              color: primaryTextColor,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: disableColor,
                              hintText: languageProvider.language
                                  ? enSubjectReport
                                  : inaSubjectReport,
                              contentPadding: const EdgeInsets.only(
                                left: paddingSmall,
                                bottom: 8.0,
                                top: 8.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: disableColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: disableColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: paddingSmall,
                          ),
                          TextField(
                            controller: descriptionController,
                            maxLines: 5,
                            style: TextStyle(
                              fontSize: small,
                              color: primaryTextColor,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: disableColor,
                              hintText: languageProvider.language
                                  ? enMessage
                                  : inaMessage,
                              contentPadding: const EdgeInsets.only(
                                left: paddingSmall,
                                bottom: paddingSmall,
                                top: paddingSmall,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: disableColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: disableColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: paddingSmall,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(radiusSmall),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: CustomText(
                                text: languageProvider.language
                                    ? enSend
                                    : inaSend,
                                color: secondaryTextColor,
                                size: normal,
                              ),
                            ),
                            onPressed: () {
                              if (titleController.text.isNotEmpty &&
                                  descriptionController.text.isNotEmpty) {
                                createReportBook(
                                    userProvider.currentUser.id,
                                    widget.book.id,
                                    titleController.text,
                                    descriptionController.text,
                                    userProvider.currentUser.phone);
                              }
                            },
                          ),
                          SizedBox(
                            height: paddingSmall,
                          ),
                        ],
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

  createReportBook(idUser, idBook, title, desc, phoneUser) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(Constanta.REPORT_BOOK));
    request.fields.addAll({
      'id_user': idUser.toString(),
      'id_catalogue': idBook.toString(),
      'title': title,
      'description': desc,
      'phone': phoneUser,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Fluttertoast.showToast(
        msg: Provider.of<LanguageProvider>(context, listen: false).language
            ? enSuccessReport
            : inaSuccessReport,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      ).then((value) => Navigator.pop(context));
    } else {
      print(response.reasonPhrase);
      Fluttertoast.showToast(
        msg: Provider.of<LanguageProvider>(context, listen: false).language
            ? enFailedReport
            : inaFailedReport,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }
}
