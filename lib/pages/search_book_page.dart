import 'package:bei/model/book.dart';
import 'package:bei/pages/detail_book_page.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/card_book_list.dart';
import 'package:bei/widgets/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController;
  List<Book> filteredList;
  String keyword;
  bool advancedSearch;

  @override
  void initState() {
    super.initState();
    searchController = new TextEditingController();
    filteredList = new List<Book>();
    keyword = '';
    advancedSearch = false;
  }

  @override
  Widget build(BuildContext context) {
    searchController.addListener(() {
      setState(() {
        keyword = searchController.text;
      });
    });

    return Consumer<BookProvider>(
      builder: (context, bookProvider, _) => Scaffold(
        body: Container(
          color: AppColor.backgroundColor,
          padding: EdgeInsets.only(
            top: AppDimen.paddingNormal,
          ),
          child: Column(
            children: [
              Container(
                height: AppDimen.appBarHeight,
                color: AppColor.backgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: AppDimen.paddingSmall,
                          right: AppDimen.paddingSmall,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Flexible(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: bookProvider.isSwitch ? 'Cari' : 'Search',
                          hintStyle: TextStyle(
                            color: AppColor.disableTextColor,
                            fontSize: AppDimen.regular,
                          ),
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: AppDimen.regular,
                          color: AppColor.primaryTextColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: AppDimen.paddingSmall,
                        ),
                        child: Icon(
                          Icons.clear,
                          color: (keyword.isEmpty)
                              ? AppColor.disableTextColor
                              : AppColor.primaryTextColor,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          searchController.text = '';
                        });
                      },
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: AppDimen.paddingSmall,
                          right: AppDimen.paddingSmall,
                        ),
                        child: Icon(
                          (advancedSearch)
                              ? Icons.arrow_drop_up_outlined
                              : Icons.arrow_drop_down_outlined,
                          color: AppColor.primaryTextColor,
                          size: 35,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          advancedSearch = !advancedSearch;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: AppColor.primaryColor,
              ),
              Visibility(
                visible: (advancedSearch) ? true : false,
                child: Container(
                  color: AppColor.backgroundColor,
                  padding: EdgeInsets.only(
                    left: AppDimen.paddingSmall,
                    right: AppDimen.paddingSmall,
                    top: AppDimen.paddingTiny,
                    bottom: AppDimen.tiny,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PrimaryText(
                        text: bookProvider.isSwitch ? 'Jenjang' : 'Level',
                        size: AppDimen.normal,
                      ),
                      Wrap(
                        children: bookProvider
                            .getAllLevel()
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.only(
                                  right: AppDimen.paddingTiny,
                                ),
                                child: FilterChip(
                                  selected: e == bookProvider.level,
                                  label: PrimaryText(
                                    text: e,
                                    size: AppDimen.small,
                                  ),
                                  onSelected: (bool selected) {
                                    bookProvider.level = e;
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: AppDimen.tiny,
                      ),
                      PrimaryText(
                        text: bookProvider.isSwitch ? 'Bidang' : 'Subject',
                        size: AppDimen.normal,
                      ),
                      Container(
                        height: AppDimen.appBarHeight,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: bookProvider
                              .getAllSubject()
                              .map(
                                (e) => Padding(
                                  padding: EdgeInsets.only(
                                    right: AppDimen.paddingTiny,
                                  ),
                                  child: FilterChip(
                                    selected: e == bookProvider.subject,
                                    label: PrimaryText(
                                      text: e,
                                      size: AppDimen.small,
                                    ),
                                    onSelected: (bool selected) {
                                      bookProvider.subject = e;
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              (keyword.isEmpty)
                  ? showOriginList(bookProvider)
                  : searchData(bookProvider),
            ],
          ),
        ),
      ),
    );
  }

  searchData(bookProvider) {
    filteredList = new List<Book>();
    for (int i = 0; i < bookProvider.getFiltered().length; i++) {
      Book item = bookProvider.getFiltered()[i];
      if (item.title.toLowerCase().contains(keyword.toLowerCase()) ||
          item.writer.toLowerCase().contains(keyword.toLowerCase())) {
        filteredList.add(item);
      }
    }
    return showFilteredList(bookProvider);
  }

  showOriginList(bookProvider) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(
          top: 0,
        ),
        shrinkWrap: true,
        itemCount: bookProvider.getFiltered().length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: CardBookList(
              book: bookProvider.getFiltered()[index],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailBookPage(
                    book: bookProvider.getFiltered()[index],
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.only(
              left: AppDimen.paddingSmall,
              right: AppDimen.paddingSmall,
            ),
            child: Divider(
              color: AppColor.primaryColor,
            ),
          );
        },
      ),
    );
  }

  showFilteredList(bookProvider) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(
          top: 0,
        ),
        shrinkWrap: true,
        itemCount: filteredList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: CardBookList(
              book: filteredList[index],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailBookPage(
                    book: filteredList[index],
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.only(
              left: AppDimen.paddingSmall,
              right: AppDimen.paddingSmall,
            ),
            child: Divider(
              color: AppColor.primaryColor,
            ),
          );
        },
      ),
    );
  }
}
