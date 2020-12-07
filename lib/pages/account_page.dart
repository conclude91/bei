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
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/card_book_thumbnail.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List listFolder = List();
  List<Book> listMyBook = List<Book>();

  @override
  void initState() {
    super.initState();
    getListFolder();
  }

  @override
  Widget build(BuildContext context) {
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
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  userProvider.currentUser.gender != null
                      ? userProvider.currentUser.gender == 'L'
                          ? Colors.blue
                          : Colors.red
                      : Colors.blue,
                  BlendMode.colorBurn,
                ),
                image: AssetImage('assets/images/background-landscape.jpg'),
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 4,
                      color: Colors.transparent,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                          top: paddingLarge,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusRegular),
                            topRight: Radius.circular(radiusRegular),
                          ),
                          color: backgroundColor,
                        ),
                        child: ListView(
                          padding: EdgeInsets.only(top: 0),
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
                                      ? userProvider.currentUser.gender == 'L'
                                          ? MdiIcons.genderMale
                                          : MdiIcons.genderFemale
                                      : null,
                                  size: regular,
                                  color: userProvider.currentUser.gender != null
                                      ? userProvider.currentUser.gender == 'L'
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
                                  text: userProvider.currentUser.phone ?? '',
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
                                Icon(Icons.location_on_outlined, size: small),
                                CustomText(
                                  text: userProvider.currentUser.address ?? '',
                                  color: primaryTextColor,
                                  size: small,
                                  maxLine: 2,
                                ),
                                CustomText(
                                  text: userProvider.currentUser.city ?? '',
                                  color: primaryTextColor,
                                  size: small,
                                  maxLine: 2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: paddingSmall,
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
                                text: languageProvider.language
                                    ? enMyBook
                                    : inaMyBook,
                                color: primaryTextColor,
                                size: normal,
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: primaryColor,
                            ),
                            Center(
                              child: Wrap(
                                spacing: 2,
                                children:
                                    List.generate(listMyBook.length, (index) {
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height / 4) - 50,
                    left: paddingNormal,
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: backgroundColor,
                    child: CircleAvatar(
                      radius: 49,
                      backgroundColor: disableColor,
                      backgroundImage: userProvider.currentUser.gender != null
                          ? userProvider.currentUser.gender == 'L'
                              ? AssetImage('assets/images/male.png')
                              : AssetImage('assets/images/female.png')
                          : AssetImage('assets/images/male.png'),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(
                      top:
                          MediaQuery.of(context).size.height / 4 + paddingSmall,
                      right: paddingSmall,
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
                              child: Icon(Icons.create_outlined)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccountDetailPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(
                      top:
                          MediaQuery.of(context).size.height / 4 + paddingSmall,
                      right: paddingSmall + 50,
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
                ),
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
}
