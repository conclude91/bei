import 'package:bei/model/book.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/card_book_gallery.dart';
import 'package:bei/widgets/card_book_list.dart';
import 'package:bei/widgets/primary_text.dart';
import 'package:bei/widgets/secondary_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailBookPage extends StatefulWidget {
  final Book book;

  DetailBookPage({this.book});

  @override
  _DetailBookPageState createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
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
                padding: EdgeInsets.only(
                  left: AppDimen.paddingSmall,
                  right: AppDimen.paddingSmall,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: AppDimen.tiny,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Row(
                      children: [
                        Icon(Icons.favorite_border),
                        SizedBox(
                          width: AppDimen.paddingSmall,
                        ),
                        Icon(Icons.file_upload),
                      ],
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
                                    text: 'Read',
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
                            text: 'Book Description',
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
                            text: 'More From Author',
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
      context: context,
      builder: (builder) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.secondaryColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
            ),
          ),
          child: ListView.separated(
            itemCount: null,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.amber,
                alignment: Alignment.centerLeft,
                height: 50,
                child: ListTile(
                  focusColor: Colors.blueAccent,
                  title: Text('Bab 4'),
                  leading: Icon(Icons.location_city),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: AppColor.primaryColor,
              );
            },
          ),
        );
      },
    );
  }
}
