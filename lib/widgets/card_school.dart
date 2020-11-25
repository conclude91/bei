import 'package:bei/pages/detail_book_page.dart';
import 'package:bei/pages/search_book_page.dart';
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
              height: 35,
              width: double.infinity,
              color: (widget.level == 'SD')
                  ? AppColor.primaryLevel
                  : (widget.level == 'SMP')
                      ? AppColor.juniorLevel
                      : AppColor.seniorLevel,
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
                      text: bookProvider.isSwitch ? 'Lihat Semua' : 'See All',
                      size: AppDimen.small,
                      color: AppColor.secondaryTextColor,
                    ),
                    onTap: () {
                      bookProvider.level = widget.level;
                      bookProvider.subject = 'All';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(),
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
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: bookProvider.getSampleByLevel(widget.level).length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: CardBookGallery(
                      book: bookProvider.getSampleByLevel(widget.level)[index],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBookPage(
                            book: bookProvider
                                .getSampleByLevel(widget.level)[index],
                          ),
                        ),
                      );
                    },
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
