import 'dart:io' as io;

import 'package:bei/model/book.dart';
import 'package:bei/pages/account_detail_page.dart';
import 'package:bei/pages/book_detail_page.dart';
import 'package:bei/pages/bookmark_page.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/provider/bookmark_provider.dart';
import 'package:bei/provider/language_provider.dart';
import 'package:bei/provider/user_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/themes/app_font.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/card_book_thumbnail.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List listFolder;
  List<Book> listMyBook;
  List<Book> filteredListMyBook;
  TextEditingController searchController;
  String keyword;

  @override
  void initState() {
    listFolder = List();
    filteredListMyBook = List<Book>();
    listMyBook = List<Book>();
    getListFolder();
    searchController = TextEditingController();
    keyword = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    searchController.addListener(() {
      setState(() {
        keyword = searchController.text;
      });
    });

    return Consumer4<BookProvider, UserProvider, BookmarkProvider,
        LanguageProvider>(
      builder: (context, bookProvider, userProvider, bookmarkProvider,
          languageProvider, _) {
        if (listMyBook.length == 0) {
          for (int i = 0; i < bookProvider.listBook.length; i++) {
            for (int y = 0; y < listFolder.length; y++) {
              if (bookProvider.listBook[i].id.toString() ==
                  listFolder[y]
                      .toString()
                      .split("/")
                      .last
                      .replaceAll("'", "")) {
                listMyBook.add(bookProvider.listBook[i]);
              }
            }
          }
        }

        return Scaffold(
          body: Container(
            padding: EdgeInsets.only(
              left: paddingSmall,
              right: paddingSmall,
              top: paddingNormal,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 125,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingTiny,
                              right: paddingTiny,
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: backgroundColor,
                              child: CircleAvatar(
                                radius: 49,
                                backgroundColor: disableColor,
                                backgroundImage: userProvider
                                                .currentUser.avatar !=
                                            null &&
                                        userProvider.currentUser.avatar !=
                                            'avatar'
                                    ? NetworkImage(
                                        userProvider.currentUser.avatar)
                                    : userProvider.currentUser.gender != null
                                        ? userProvider.currentUser.gender == 'L'
                                            ? AssetImage(
                                                'assets/images/male.png')
                                            : AssetImage(
                                                'assets/images/female.png')
                                        : AssetImage('assets/images/male.png'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CustomText(
                                        text: userProvider.currentUser.name,
                                        color: primaryTextColor,
                                        size: regular,
                                        weight: FontWeight.bold,
                                      ),
                                      SizedBox(
                                        width: paddingTiny,
                                      ),
                                      Icon(
                                        userProvider.currentUser.gender != null
                                            ? userProvider.currentUser.gender ==
                                                    'L'
                                                ? MdiIcons.genderMale
                                                : MdiIcons.genderFemale
                                            : null,
                                        size: regular,
                                        color: userProvider
                                                    .currentUser.gender !=
                                                null
                                            ? userProvider.currentUser.gender ==
                                                    'L'
                                                ? Colors.blue
                                                : Colors.pink
                                            : primaryTextColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: paddingTiny,
                                  ),
                                  Wrap(
                                    spacing: 5,
                                    children: [
                                      Icon(
                                        Icons.email_outlined,
                                        size: small,
                                      ),
                                      CustomText(
                                        text: userProvider.currentUser.email,
                                        color: primaryTextColor,
                                        size: small,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: paddingTiny,
                                  ),
                                  Wrap(
                                    spacing: 5,
                                    children: [
                                      Icon(Icons.phone_outlined, size: small),
                                      CustomText(
                                        text: userProvider.currentUser.phone ??
                                            '',
                                        color: primaryTextColor,
                                        size: small,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: paddingTiny,
                                  ),
                                  Wrap(
                                    spacing: 5,
                                    children: [
                                      Icon(Icons.location_on_outlined,
                                          size: small),
                                      CustomText(
                                        text:
                                            userProvider.currentUser.address ??
                                                '',
                                        color: primaryTextColor,
                                        size: small,
                                        maxLine: 2,
                                      ),
                                      CustomText(
                                        text:
                                            userProvider.currentUser.city ?? '',
                                        color: primaryTextColor,
                                        size: small,
                                        maxLine: 2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: paddingTiny,
                        bottom: paddingTiny,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: paddingTiny,
                            ),
                            child: ClipOval(
                              child: Material(
                                color: disableColor,
                                child: InkWell(
                                  splashColor: backgroundColor,
                                  child: SizedBox(
                                    width: 35,
                                    height: 35,
                                    child: Icon(Icons.bookmark_outline),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BookmarkPage(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: paddingSmall,
                            ),
                            child: ClipOval(
                              child: Material(
                                color: disableColor,
                                child: InkWell(
                                  splashColor: backgroundColor,
                                  child: SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: Icon(Icons.create_outlined)),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AccountDetailPage(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 1,
                  color: primaryColor,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: CustomText(
                    text: languageProvider.language ? enMyBook : inaMyBook,
                    color: primaryTextColor,
                    size: normal,
                  ),
                ),
                TextField(
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
                        Icons.backspace_outlined,
                        size: 20,
                        color: primaryTextColor,
                      ),
                      onPressed: () => searchController.clear(),
                    ),
                    hintText: languageProvider.language ? enSearch : inaSearch,
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
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                  color: primaryColor,
                ),
                (keyword.isEmpty) ? showOriginList() : searchData(),
              ],
            ),
          ),
        );
      },
    );
  }

  getListFolder() async {
    var directory = (await getExternalStorageDirectory()).path;
    setState(() {
      listFolder = io.Directory(directory.toString()).listSync();
    });
  }

  searchData() {
    filteredListMyBook = List<Book>();
    for (int i = 0; i < listMyBook.length; i++) {
      Book item = listMyBook[i];
      if (item.title.toLowerCase().contains(keyword.toLowerCase())) {
        filteredListMyBook.add(item);
      }
    }
    return showFilteredList();
  }

  showOriginList() {
    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          child: Wrap(
            spacing: 2,
            children: List.generate(listMyBook.length, (index) {
              return InkWell(
                child: CardBookThumbnail(
                  book: listMyBook[index],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailPage(
                        book: listMyBook[index],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }

  showFilteredList() {
    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          child: Wrap(
            spacing: 2,
            children: List.generate(filteredListMyBook.length, (index) {
              return InkWell(
                child: CardBookThumbnail(
                  book: filteredListMyBook[index],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailPage(
                        book: filteredListMyBook[index],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
