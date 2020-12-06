import 'package:bei/model/book.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';

class CardBookThumbnail extends StatefulWidget {
  final Book book;

  CardBookThumbnail({
    @required this.book,
  });

  @override
  _CardBookThumbnailState createState() => _CardBookThumbnailState();
}

class _CardBookThumbnailState extends State<CardBookThumbnail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
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
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 0),
          children: [
            Container(
              height: 145,
              width: 125,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImageWithRetry(
                    widget.book.image,
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusSmall),
                  topRight: Radius.circular(radiusSmall),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 45,
              width: double.infinity,
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: widget.book.title,
                    size: tiny,
                    maxLine: 2,
                  ),
                  CustomText(
                    text: widget.book.level,
                    size: tiny,
                    color: (widget.book.level == 'SD')
                        ? primaryLevelColor
                        : (widget.book.level == 'SMP')
                            ? juniorLevelColor
                            : seniorLevelColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
