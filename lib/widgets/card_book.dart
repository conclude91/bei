import 'package:bei/model/book.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';

class CardBook extends StatefulWidget {
  final Book book;

  CardBook({
    this.book,
  });

  @override
  _CardBookState createState() => _CardBookState();
}

class _CardBookState extends State<CardBook> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 350,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              color: backgroundColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: primaryColor,
                  width: 0.1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(radiusSmall),
                ),
              ),
              elevation: elevation,
              child: Container(
                height: 125,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(
                bottom: paddingTiny,
                left: paddingTiny,
              ),
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImageWithRetry(
                    widget.book.image,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(
                  radiusSmall,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 108,
              width: double.infinity,
              margin: EdgeInsets.only(
                left: 116,
                bottom: paddingTiny,
                right: paddingTiny,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: widget.book.title,
                    size: small,
                    maxLine: 2,
                  ),
                  Divider(
                    color: primaryColor,
                  ),
                  Container(
                    height: 50,
                    child: CustomText(
                      text: widget.book.description,
                      size: tiny,
                      maxLine: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: paddingTiny,
                right: small,
              ),
              child: CustomText(
                text: widget.book.level,
                size: tiny,
                color: (widget.book.level == 'SD')
                    ? primaryLevelColor
                    : (widget.book.level == 'SMP')
                        ? juniorLevelColor
                        : seniorLevelColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
