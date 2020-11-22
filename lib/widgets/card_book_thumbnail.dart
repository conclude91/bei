import 'package:bei/model/book.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/primary_text.dart';
import 'package:flutter/material.dart';

class CardBookThumbnail extends StatefulWidget {
  final Book book;

  CardBookThumbnail({this.book});

  @override
  _CardBookThumbnailState createState() => _CardBookThumbnailState();
}

class _CardBookThumbnailState extends State<CardBookThumbnail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimen.radiusSmall),
          ),
        ),
        elevation: AppDimen.elevation,
        child: Column(
          children: [
            Container(
              height: 150,
              width: 125,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.book.image,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppDimen.radiusSmall),
                  topRight: Radius.circular(AppDimen.radiusSmall),
                ),
              ),
            ),
            SizedBox(
              height: AppDimen.paddingTiny,
            ),
            Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    text: widget.book.title,
                    size: AppDimen.tiny,
                    maxLine: 2,
                  ),
                  PrimaryText(
                    text: widget.book.level,
                    size: AppDimen.tiny,
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
