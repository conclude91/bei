import 'package:bei/pages/detail_book_page.dart';
import 'package:bei/pages/search_book_page.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/provider/chapter_provider.dart';
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
      Provider.of<BookProvider>(context, listen: false).fetchDataPopular();
      Provider.of<ChapterProvider>(context, listen: false).fecthData();
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
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: AppDimen.appBarHeight,
                      padding: EdgeInsets.only(
                        left: AppDimen.paddingSmall,
                        right: AppDimen.paddingSmall,
                      ),
                      child: IntrinsicWidth(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: PrimaryText(
                                    text: 'SIBI',
                                    size: AppDimen.medium,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: GestureDetector(
                                child: Container(
                                  height: 35,
                                  margin: EdgeInsets.only(
                                    left: AppDimen.paddingTiny,
                                    right: AppDimen.paddingTiny,
                                  ),
                                  padding: EdgeInsets.only(
                                    left: AppDimen.paddingTiny,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.disableColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.search,
                                        color: AppColor.disableTextColor,
                                      ),
                                      SizedBox(
                                        width: AppDimen.tiny,
                                      ),
                                      PrimaryText(
                                        text: bookProvider.isSwitch
                                            ? 'Cari'
                                            : 'Search',
                                        size: AppDimen.normal,
                                        color: AppColor.disableTextColor,
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  bookProvider.level = 'All';
                                  bookProvider.subject = 'All';
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchPage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Center(
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColor.primaryColor,
                                    child: CircleAvatar(
                                      radius: 19,
                                      backgroundImage: AssetImage(
                                          'assets/images/male.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: AppColor.primaryColor,
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(
                          top: 0,
                        ),
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: AppDimen.paddingSmall,
                              right: AppDimen.paddingSmall,
                            ),
                            child: PlaceHolder(),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                              left: AppDimen.paddingSmall,
                              right: AppDimen.paddingSmall,
                            ),
                            child: PrimaryText(
                              text: bookProvider.isSwitch
                                  ? 'Jenjang Sekolah :'
                                  : 'School Levels :',
                              size: AppDimen.normal,
                            ),
                          ),
                          SizedBox(
                            height: AppDimen.paddingTiny,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: AppDimen.paddingTiny,
                              right: AppDimen.paddingTiny,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: AppDimen.paddingTiny,
                                      bottom: AppDimen.paddingTiny,
                                      left: AppDimen.paddingSmall,
                                      right: AppDimen.paddingSmall,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: (bookProvider.level == 'All')
                                            ? AppColor.primaryColor
                                            : AppColor.secondaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: PrimaryText(
                                      text: bookProvider.isSwitch
                                          ? 'Semua'
                                          : 'All',
                                      size: AppDimen.normal,
                                      color: AppColor.primaryTextColor,
                                    ),
                                  ),
                                  onTap: () {
                                    bookProvider.level = 'All';
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: AppDimen.paddingTiny,
                                      bottom: AppDimen.paddingTiny,
                                      left: AppDimen.paddingSmall,
                                      right: AppDimen.paddingSmall,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: (bookProvider.level == 'SD')
                                            ? AppColor.primaryColor
                                            : AppColor.secondaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: PrimaryText(
                                      text: bookProvider.isSwitch
                                          ? 'SD/MI'
                                          : 'Primary',
                                      size: AppDimen.normal,
                                      color: AppColor.primaryTextColor,
                                    ),
                                  ),
                                  onTap: () {
                                    bookProvider.level = 'SD';
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: AppDimen.paddingTiny,
                                      bottom: AppDimen.paddingTiny,
                                      left: AppDimen.paddingSmall,
                                      right: AppDimen.paddingSmall,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: (bookProvider.level == 'SMP')
                                            ? AppColor.primaryColor
                                            : AppColor.secondaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: PrimaryText(
                                      text: bookProvider.isSwitch
                                          ? 'SMP/MTS'
                                          : 'Junior',
                                      size: AppDimen.normal,
                                      color: AppColor.primaryTextColor,
                                    ),
                                  ),
                                  onTap: () {
                                    bookProvider.level = 'SMP';
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: AppDimen.paddingTiny,
                                      bottom: AppDimen.paddingTiny,
                                      left: AppDimen.paddingSmall,
                                      right: AppDimen.paddingSmall,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: (bookProvider.level == 'SMA')
                                            ? AppColor.primaryColor
                                            : AppColor.secondaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: PrimaryText(
                                      text: bookProvider.isSwitch
                                          ? 'SMA/SMK/MA'
                                          : 'Senior',
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
                              itemCount: bookProvider.getRecentByLevel.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  child: CardBook(
                                    book: bookProvider.getRecentByLevel[index],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailBookPage(
                                          book: bookProvider
                                              .getRecentByLevel[index],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox.shrink();
                              },
                            ),
                          ),
                          SizedBox(
                            height: AppDimen.small,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                              left: AppDimen.paddingSmall,
                              right: AppDimen.paddingSmall,
                            ),
                            child: PrimaryText(
                              text: bookProvider.isSwitch
                                  ? 'Buku Populer :'
                                  : 'The most popular :',
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
                              itemCount: bookProvider.getPopular().length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  child: CardBookThumbnail(
                                    book: bookProvider.getPopular()[index],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailBookPage(
                                          book:
                                              bookProvider.getPopular()[index],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox.shrink();
                              },
                            ),
                          ),
                          SizedBox(
                            height: AppDimen.small,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                              left: AppDimen.paddingSmall,
                              right: AppDimen.paddingSmall,
                            ),
                            child: PrimaryText(
                              text: bookProvider.isSwitch
                                  ? 'Buku Terbaru :'
                                  : 'Recently added :',
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
                              itemBuilder: (context, index) {
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
                              separatorBuilder: (context, index) {
                                return SizedBox.shrink();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
