import 'package:bei/model/book.dart';
import 'package:bei/pages/book_detail_page.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/themes/app_font.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/card_book.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          color: greyLightColor,
          padding: EdgeInsets.only(
            top: paddingNormal,
          ),
          child: Column(
            children: [
              Container(
                height: appBarHeight,
                color: backgroundColor,
                child: Material(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: paddingTiny,
                          right: paddingTiny,
                        ),
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(paddingTiny),
                            child: Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: paddingMicro,
                            bottom: paddingMicro,
                          ),
                          child: TextField(
                            controller: searchController,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                size: 20,
                                color: primaryTextColor,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.backspace,
                                  size: 20,
                                  color: primaryTextColor,
                                ),
                                onPressed: () => searchController.clear(),
                              ),
                              hintText: enSearch,
                              hintStyle: GoogleFonts.roboto(
                                color: primaryTextColor,
                                fontWeight: fontlight,
                                fontSize: normal,
                              ),
                              filled: true,
                              fillColor: disableColor,
                              contentPadding: EdgeInsets.only(
                                bottom: paddingSmall - 6,
                              ),
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryTextColor,
                                  width: 0.1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryTextColor,
                                  width: 0.1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: paddingTiny,
                          right: paddingTiny,
                        ),
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(paddingTiny),
                            child: Icon(
                              Icons.more_vert_outlined,
                              color: primaryTextColor,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              advancedSearch = !advancedSearch;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: primaryColor,
                height: 1,
              ),
              Visibility(
                visible: (advancedSearch) ? true : false,
                child: Container(
                  padding: EdgeInsets.only(
                    top: paddingTiny,
                    bottom: tiny,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    border: Border(
                      bottom: BorderSide(
                        color: primaryColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                        ),
                        child: Row(
                          children: [
                            CustomText(
                              text: bookProvider.isSwitch
                                  ? 'Jenjang :'
                                  : 'Level :',
                              size: small,
                            ),
                            SizedBox(
                              width: paddingTiny,
                            ),
                            Expanded(
                              child: Container(
                                child: Wrap(
                                  spacing: 10,
                                  children: bookProvider
                                      .getAllLevel()
                                      .map(
                                        (e) => FilterChip(
                                          backgroundColor: Colors.transparent,
                                          shape: StadiumBorder(
                                            side: BorderSide(
                                              color: primaryTextColor,
                                              width: 0.5,
                                            ),
                                          ),
                                          selected: e == bookProvider.level,
                                          label: CustomText(
                                            text: e.toUpperCase(),
                                            size: tiny,
                                          ),
                                          onSelected: (bool selected) {
                                            bookProvider.level = e;
                                            bookProvider.group = 'All';
                                            bookProvider.subject = 'All';
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text:
                                  bookProvider.isSwitch ? 'Kelas :' : 'Class :',
                              size: small,
                            ),
                            SizedBox(
                              width: paddingTiny,
                            ),
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: bookProvider
                                    .getAllClass()
                                    .map(
                                      (e) => Padding(
                                        padding: EdgeInsets.only(
                                          right: paddingTiny,
                                        ),
                                        child: FilterChip(
                                          backgroundColor: Colors.transparent,
                                          shape: StadiumBorder(
                                            side: BorderSide(
                                              color: primaryTextColor,
                                              width: 0.5,
                                            ),
                                          ),
                                          selected: e == bookProvider.group,
                                          label: CustomText(
                                            text: e.toUpperCase(),
                                            size: tiny,
                                          ),
                                          onSelected: (bool selected) {
                                            bookProvider.group = e;
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
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: bookProvider.isSwitch
                                  ? 'Bidang :'
                                  : 'Subject :',
                              size: small,
                            ),
                            SizedBox(
                              width: paddingTiny,
                            ),
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: bookProvider
                                    .getAllSubject()
                                    .map(
                                      (e) => Padding(
                                        padding: EdgeInsets.only(
                                          right: paddingTiny,
                                        ),
                                        child: FilterChip(
                                          backgroundColor: Colors.transparent,
                                          shape: StadiumBorder(
                                            side: BorderSide(
                                              color: primaryTextColor,
                                              width: 0.5,
                                            ),
                                          ),
                                          selected: e == bookProvider.subject,
                                          label: CustomText(
                                            text: e.toUpperCase(),
                                            size: tiny,
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
      child: Padding(
        padding: EdgeInsets.only(
          left: paddingSmall,
          right: paddingSmall,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: bookProvider.getFiltered().length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: CardBook(
                book: bookProvider.getFiltered()[index],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(
                      book: bookProvider.getFiltered()[index],
                    ),
                  ),
                );
              },
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: paddingSmall,
            );
          },
        ),
      ),
    );
  }

  showFilteredList(bookProvider) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: paddingSmall,
          right: paddingSmall,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: CardBook(
                book: filteredList[index],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(
                      book: filteredList[index],
                    ),
                  ),
                );
              },
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: paddingSmall,
            );
          },
        ),
      ),
    );
  }
}
