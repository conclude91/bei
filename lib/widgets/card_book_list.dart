import 'package:bei/model/book.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/card_book_gallery.dart';
import 'package:bei/widgets/custom_text.dart';
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
        left: paddingSmall,
        right: paddingSmall,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: paddingSmall,
              ),
              child: Card(
                color: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(radiusSmall),
                  ),
                ),
                elevation: elevation,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 125 + paddingTiny,
                      right: paddingTiny,
                      top: paddingTiny,
                      bottom: paddingTiny,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: widget.book.title,
                          size: normal,
                          maxLine: 2,
                        ),
                        CustomText(
                          text: widget.book.writer,
                          size: small,
                          maxLine: 2,
                        ),
                        CustomText(
                          text: widget.book.description,
                          size: tiny,
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
                bottom: paddingSmall + 4,
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
