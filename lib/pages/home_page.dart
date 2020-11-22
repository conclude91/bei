import 'package:bei/pages/detail_book_page.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/card_book.dart';
import 'package:bei/widgets/card_book_thumbnail.dart';
import 'package:bei/widgets/placeholder.dart';
import 'package:bei/widgets/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookProvider>(context, listen: false).fecthData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, _) => (bookProvider.listBook.length ==
                  0 &&
              bookProvider.listBook == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              backgroundColor: AppColor.backgroundColor,
              body: Container(
                padding: EdgeInsets.only(
                  top: AppDimen.paddingNormal,
                  left: AppDimen.paddingSmall,
                  right: AppDimen.paddingSmall,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: AppDimen.appBarHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrimaryText(
                              text: 'Hi John,',
                              size: AppDimen.medium,
                            ),
                            Row(
                              children: [
                                Icon(Icons.search),
                                SizedBox(
                                  width: AppDimen.paddingSmall,
                                ),
                                Icon(Icons.notifications),
                              ],
                            ),
                          ],
                        ),
                      ),
                      PlaceHolder(),
                      Container(
                        width: double.infinity,
                        child: PrimaryText(
                          text: 'School Levels :',
                          size: AppDimen.normal,
                        ),
                      ),
                      SizedBox(
                        height: AppDimen.paddingTiny,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: AppDimen.paddingTiny,
                                  right: AppDimen.paddingTiny,
                                ),
                                child: PrimaryText(
                                  text: 'All',
                                  size: AppDimen.normal,
                                  color: AppColor.primaryTextColor,
                                ),
                              ),
                              onTap: () {
                                bookProvider.level = 'All';
                              },
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: AppDimen.paddingTiny,
                                  right: AppDimen.paddingTiny,
                                ),
                                child: PrimaryText(
                                  text: 'Primary',
                                  size: AppDimen.normal,
                                  color: AppColor.primaryTextColor,
                                ),
                              ),
                              onTap: () {
                                bookProvider.level = 'SD';
                              },
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: AppDimen.paddingTiny,
                                  right: AppDimen.paddingTiny,
                                ),
                                child: PrimaryText(
                                  text: 'Junior',
                                  size: AppDimen.normal,
                                  color: AppColor.primaryTextColor,
                                ),
                              ),
                              onTap: () {
                                bookProvider.level = 'SMP';
                              },
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: AppDimen.paddingTiny,
                                  right: AppDimen.paddingTiny,
                                ),
                                child: PrimaryText(
                                  text: 'Senior',
                                  size: AppDimen.normal,
                                  color: AppColor.primaryTextColor,
                                ),
                              ),
                              onTap: () {
                                bookProvider.level = 'SMA';
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppDimen.paddingSmall,
                      ),
                      Container(
                        height: 150,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return CardBook(
                              book: bookProvider.getRecentByLevel[index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox.shrink();
                          },
                          itemCount: bookProvider.getRecentByLevel.length,
                        ),
                      ),
                      SizedBox(
                        height: AppDimen.small,
                      ),
                      Container(
                        width: double.infinity,
                        child: PrimaryText(
                          text: 'The most popular :',
                          size: AppDimen.normal,
                        ),
                      ),
                      Container(
                        height: 245,
                        padding: EdgeInsets.only(
                          top: AppDimen.paddingTiny,
                          bottom: AppDimen.paddingTiny,
                        ),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: bookProvider.getRecentAll.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return GestureDetector(
                              child: CardBookThumbnail(
                                book: bookProvider.getRecentAll[index],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailBookPage(
                                      book: bookProvider.listBook[index],
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
                      SizedBox(
                        height: AppDimen.small,
                      ),
                      Container(
                        width: double.infinity,
                        child: PrimaryText(
                          text: 'Recently added :',
                          size: AppDimen.normal,
                        ),
                      ),
                      Container(
                        height: 245,
                        padding: EdgeInsets.only(
                          top: AppDimen.paddingTiny,
                          bottom: AppDimen.paddingTiny,
                        ),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: bookProvider.getRecentAll.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return GestureDetector(
                              child: CardBookThumbnail(
                                book: bookProvider.getRecentAll[index],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailBookPage(
                                      book: bookProvider.listBook[index],
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
              ),
            ),
    );
  }
}
