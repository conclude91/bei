import 'package:bei/model/book.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/card_book_list.dart';
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

  @override
  void initState() {
    super.initState();
    searchController = new TextEditingController();
    filteredList = new List<Book>();
    keyword = '';
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
                padding: EdgeInsets.only(
                  left: AppDimen.paddingSmall,
                  right: AppDimen.paddingSmall,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: AppDimen.tiny,
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
                          hintText: 'Search',
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
                          left: AppDimen.paddingTiny,
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
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: AppColor.primaryColor,
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
    for (int i = 0; i < bookProvider.getAll().length; i++) {
      Book item = bookProvider.getAll()[i];
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
        itemCount: bookProvider.getAll().length,
        itemBuilder: (BuildContext context, int index) {
          return CardBookList(
            book: bookProvider.getAll()[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.only(
              left: AppDimen.paddingNormal,
              right: AppDimen.paddingNormal,
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
          return CardBookList(
            book: filteredList[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.only(
              left: AppDimen.paddingNormal,
              right: AppDimen.paddingNormal,
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
