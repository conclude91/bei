import 'package:bei/model/book.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';

class CardBookGallery extends StatefulWidget {
  final Book book;

  CardBookGallery({this.book});

  @override
  _CardBookGalleryState createState() => _CardBookGalleryState();
}

class _CardBookGalleryState extends State<CardBookGallery> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 130,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radiusSmall),
          ),
        ),
        elevation: elevation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              radiusNormal,
            ),
            image: DecorationImage(
              image: NetworkImageWithRetry(
                widget.book.image,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
