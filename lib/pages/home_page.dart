import 'package:bei/pages/account_detail_page.dart';
import 'package:bei/pages/book_detail_page.dart';
import 'package:bei/pages/search_page.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/provider/language_provider.dart';
import 'package:bei/provider/user_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/card_book.dart';
import 'package:bei/widgets/card_book_thumbnail.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:bei/widgets/placeholder.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<BookProvider, UserProvider, LanguageProvider>(
      builder: (context, bookProvider, userProvider, languageProvider, _) =>
          (bookProvider.listBook.length == 0 &&
                  bookProvider.listBook == null &&
                  userProvider.listUser == null)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  backgroundColor: backgroundColor,
                  body: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: backgroundColor,
                          height: appBarHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: paddingSmall,
                                  right: paddingSmall,
                                ),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  height: large,
                                  width: large,
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(
                                      left: paddingTiny,
                                      right: paddingTiny,
                                    ),
                                    margin: EdgeInsets.only(
                                      top: paddingMicro,
                                      bottom: paddingMicro,
                                      right: paddingMicro,
                                    ),
                                    decoration: BoxDecoration(
                                      color: disableColor,
                                      border: Border.all(
                                        color: primaryTextColor,
                                        width: 0.1,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(radiusSmall),
                                    ),
                                    child: Wrap(
                                      spacing: 10,
                                      children: [
                                        Icon(
                                          Icons.search_rounded,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 3),
                                          child: CustomText(
                                            text: languageProvider.language
                                                ? enSearch
                                                : inaSearch,
                                            size: normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    bookProvider.level = 'All';
                                    bookProvider.group = 'All';
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
                              Padding(
                                padding: EdgeInsets.only(
                                  right: paddingSmall,
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      child: Padding(
                                        padding: EdgeInsets.all(paddingMicro),
                                        child: CircleAvatar(
                                          radius: regular,
                                          backgroundColor: primaryColor,
                                          child: CircleAvatar(
                                            radius: regular - 1,
                                            backgroundColor: disableColor,
                                            backgroundImage: userProvider
                                                            .currentUser
                                                            .avatar !=
                                                        null &&
                                                    userProvider.currentUser
                                                            .avatar !=
                                                        'avatar'
                                                ? NetworkImage(userProvider
                                                    .currentUser.avatar)
                                                : userProvider.currentUser
                                                            .gender !=
                                                        null
                                                    ? userProvider.currentUser
                                                                .gender ==
                                                            'L'
                                                        ? AssetImage(
                                                            'assets/images/male.png')
                                                        : AssetImage(
                                                            'assets/images/female.png')
                                                    : AssetImage(
                                                        'assets/images/male.png'),
                                          ),
                                        ),
                                      ),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: primaryColor,
                          height: 1,
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
                                  left: paddingSmall,
                                  right: paddingSmall,
                                ),
                                child: PlaceHolder(),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: paddingSmall - 3,
                                  right: paddingSmall - 3,
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: primaryColor,
                                      width: 0.1,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(radiusSmall),
                                    ),
                                  ),
                                  elevation: elevation,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: paddingTiny,
                                      bottom: paddingTiny,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(
                                            left: paddingTiny,
                                            right: paddingTiny,
                                          ),
                                          child: CustomText(
                                            text: languageProvider.language
                                                ? enSchoolLevel
                                                : inaSchoolLevel,
                                            size: small,
                                          ),
                                        ),
                                        SizedBox(
                                          height: paddingTiny,
                                        ),
                                        Container(
                                          height: 25,
                                          padding: EdgeInsets.only(
                                            left: paddingTiny,
                                            right: paddingTiny,
                                          ),
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: paddingMicro,
                                                    bottom: paddingMicro,
                                                    left: paddingSmall,
                                                    right: paddingSmall,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: bookProvider.level ==
                                                            'All'
                                                        ? primaryColor
                                                        : backgroundColor,
                                                    border: Border.all(
                                                      color: primaryColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: CustomText(
                                                    text: languageProvider
                                                            .language
                                                        ? enAll
                                                        : inaAll,
                                                    size: small,
                                                    color: bookProvider.level ==
                                                            'All'
                                                        ? secondaryTextColor
                                                        : primaryTextColor,
                                                  ),
                                                ),
                                                onTap: () {
                                                  bookProvider.level = 'All';
                                                },
                                              ),
                                              SizedBox(width: paddingTiny),
                                              GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: paddingMicro,
                                                    bottom: paddingMicro,
                                                    left: paddingSmall,
                                                    right: paddingSmall,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: bookProvider.level ==
                                                            'SD'
                                                        ? primaryColor
                                                        : backgroundColor,
                                                    border: Border.all(
                                                      color: primaryColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: CustomText(
                                                    text: languageProvider
                                                            .language
                                                        ? enPrimary
                                                        : inaPrimary,
                                                    size: small,
                                                    color: bookProvider.level ==
                                                            'SD'
                                                        ? secondaryTextColor
                                                        : primaryTextColor,
                                                  ),
                                                ),
                                                onTap: () {
                                                  bookProvider.level = 'SD';
                                                },
                                              ),
                                              SizedBox(width: paddingTiny),
                                              GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: paddingMicro,
                                                    bottom: paddingMicro,
                                                    left: paddingSmall,
                                                    right: paddingSmall,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: bookProvider.level ==
                                                            'SMP'
                                                        ? primaryColor
                                                        : backgroundColor,
                                                    border: Border.all(
                                                      color: primaryColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: CustomText(
                                                    text: languageProvider
                                                            .language
                                                        ? enJunior
                                                        : inaJunior,
                                                    size: small,
                                                    color: bookProvider.level ==
                                                            'SMP'
                                                        ? secondaryTextColor
                                                        : primaryTextColor,
                                                  ),
                                                ),
                                                onTap: () {
                                                  bookProvider.level = 'SMP';
                                                },
                                              ),
                                              SizedBox(width: paddingTiny),
                                              GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: paddingMicro,
                                                    bottom: paddingMicro,
                                                    left: paddingSmall,
                                                    right: paddingSmall,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: bookProvider.level ==
                                                            'SMA'
                                                        ? primaryColor
                                                        : backgroundColor,
                                                    border: Border.all(
                                                      color: primaryColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: CustomText(
                                                    text: languageProvider
                                                            .language
                                                        ? enSenior
                                                        : inaSenior,
                                                    size: small,
                                                    color: bookProvider.level ==
                                                            'SMA'
                                                        ? secondaryTextColor
                                                        : primaryTextColor,
                                                  ),
                                                ),
                                                onTap: () {
                                                  bookProvider.level = 'SMA';
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: paddingSmall,
                              ),
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: blueLightColor,
                                  border: Border(
                                    top: BorderSide(
                                      color: primaryColor,
                                      width: 0.5,
                                    ),
                                    bottom: BorderSide(
                                      color: disableColor,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                  left: paddingSmall,
                                  right: paddingSmall,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: languageProvider.language
                                          ? enRecently
                                          : inaRecently,
                                      size: small,
                                    ),
                                    InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: CustomText(
                                          text: languageProvider.language
                                              ? enAllBook
                                              : inaAllBook,
                                          size: tiny,
                                        ),
                                      ),
                                      onTap: () {
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
                                height: 166,
                                padding: EdgeInsets.only(
                                  top: paddingTiny,
                                  bottom: paddingTiny,
                                ),
                                decoration: BoxDecoration(
                                  color: blueLightColor,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: primaryColor,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: bookProvider.getRecent().length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          left:
                                              index == 0 ? paddingSmall - 3 : 0,
                                          right: index ==
                                                  bookProvider
                                                          .getRecent()
                                                          .length -
                                                      1
                                              ? paddingSmall - 3
                                              : 0,
                                        ),
                                        child: CardBook(
                                          book: bookProvider.getRecent()[index],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BookDetailPage(
                                              book: bookProvider
                                                  .getRecent()[index],
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
                                height: paddingNormal,
                              ),
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: greenLightColor,
                                  border: Border(
                                    top: BorderSide(
                                        color: primaryColor, width: 0.5),
                                    bottom: BorderSide(
                                      color: disableColor,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                  left: paddingSmall,
                                  right: paddingSmall,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: languageProvider.language
                                          ? enRecomendedBook
                                          : inaRecomendedBook,
                                      size: small,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 225,
                                padding: EdgeInsets.only(
                                  top: paddingTiny,
                                  bottom: paddingTiny,
                                ),
                                decoration: BoxDecoration(
                                  color: greenLightColor,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: primaryColor,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: bookProvider.getPopular().length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          left:
                                              index == 0 ? paddingSmall - 3 : 0,
                                          right: index ==
                                                  bookProvider
                                                          .getPopular()
                                                          .length -
                                                      1
                                              ? paddingSmall - 3
                                              : 0,
                                        ),
                                        child: CardBookThumbnail(
                                          book:
                                              bookProvider.getPopular()[index],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BookDetailPage(
                                              book: bookProvider
                                                  .getPopular()[index],
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
