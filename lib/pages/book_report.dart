import 'package:bei/consts/constanta.dart';
import 'package:bei/model/book.dart';
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
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) => Scaffold(
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
                          text: 'Book Report',
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
                                  text: widget.book.writer,
                                  size: small,
                                  maxLine: 3,
                                ),
                                CustomText(
                                  text: lorem,
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
                            text: 'Report Data :',
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
                              hintText: 'Subject',
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
                              hintText: 'Messages',
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
                          FlatButton(
                            height: 50,
                            color: primaryLevelColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(radiusSmall),
                            ),
                            child: CustomText(
                              text: 'Send',
                              color: secondaryTextColor,
                              size: small,
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
        msg: 'Report has been sent',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      Navigator.pop(context);
    } else {
      print(response.reasonPhrase);
      Fluttertoast.showToast(
        msg: 'Unable to send report',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }
}
