import 'package:bei/model/book.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/card_book_gallery.dart';
import 'package:bei/widgets/primary_text.dart';
import 'package:flutter/material.dart';

class CardBookList extends StatefulWidget {
  final Book book;

  CardBookList({this.book});

  @override
  _CardBookListState createState() => _CardBookListState();
}

class _CardBookListState extends State<CardBookList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: double.infinity,
      padding: EdgeInsets.only(
        left: AppDimen.paddingSmall,
        right: AppDimen.paddingSmall,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: AppDimen.paddingSmall,
              ),
              child: Card(
                color: AppColor.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimen.radiusSmall),
                  ),
                ),
                elevation: AppDimen.elevation,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 125 + AppDimen.paddingTiny,
                      right: AppDimen.paddingTiny,
                      top: AppDimen.paddingTiny,
                      bottom: AppDimen.paddingTiny,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryText(
                          text: widget.book.title,
                          size: AppDimen.normal,
                          maxLine: 2,
                        ),
                        PrimaryText(
                          text: widget.book.writer,
                          size: AppDimen.small,
                          maxLine: 2,
                        ),
                        PrimaryText(
                          text: widget.book.description,
                          size: AppDimen.tiny,
                          maxLine: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 180,
              margin: EdgeInsets.only(
                bottom: AppDimen.paddingSmall + 4,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 4,
                ),
                child: CardBookGallery(
                  book: widget.book,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
