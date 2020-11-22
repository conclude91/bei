import 'package:bei/pages/list_book_page.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/card_book_gallery.dart';
import 'package:bei/widgets/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardSchool extends StatefulWidget {
  final String level;

  CardSchool({this.level});

  @override
  _CardSchoolState createState() => _CardSchoolState();
}

class _CardSchoolState extends State<CardSchool> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, _) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: double.infinity,
              color: AppColor.primaryColor,
              padding: EdgeInsets.only(
                left: AppDimen.paddingSmall,
                right: AppDimen.paddingSmall,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    text: widget.level,
                    size: AppDimen.normal,
                    color: AppColor.secondaryTextColor,
                  ),
                  GestureDetector(
                    child: PrimaryText(
                      text: 'See All',
                      size: AppDimen.small,
                      color: AppColor.secondaryTextColor,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListBookPage(
                            level: widget.level,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 216,
              padding: EdgeInsets.only(
                top: AppDimen.paddingTiny,
                bottom: AppDimen.paddingTiny,
                left: AppDimen.paddingSmall,
                right: AppDimen.paddingSmall,
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: bookProvider.getSampleByLevel(widget.level).length,
                itemBuilder: (BuildContext context, int index) {
                  return CardBookGallery(
                    book: bookProvider.getSampleByLevel(widget.level)[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
