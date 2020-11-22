import 'package:bei/model/book.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/primary_text.dart';
import 'package:flutter/material.dart';

class CardBook extends StatefulWidget {
  final Book book;

  CardBook({this.book});

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
              color: AppColor.secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimen.radiusSmall),
                ),
              ),
              elevation: AppDimen.elevation,
              child: Container(
                height: 125,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(
                bottom: AppDimen.paddingTiny,
                left: AppDimen.paddingTiny,
              ),
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.book.image,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(
                  AppDimen.radiusSmall,
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
                bottom: AppDimen.paddingTiny,
                right: AppDimen.paddingTiny,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                    text: widget.book.title,
                    size: AppDimen.normal,
                  ),
                  Divider(),
                  Container(
                    height: 50,
                    child: PrimaryText(
                      text: widget.book.description,
                      size: AppDimen.tiny,
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
              padding: EdgeInsets.all(
                AppDimen.paddingTiny,
              ),
              child: PrimaryText(
                text: 'More',
                size: AppDimen.tiny,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
