import 'dart:io';

import 'package:bei/pages/account_page.dart';
import 'package:bei/pages/home_page.dart';
import 'package:bei/pages/setting_page.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/provider/bookmark_provider.dart';
import 'package:bei/provider/chapter_provider.dart';
import 'package:bei/provider/language_provider.dart';
import 'package:bei/provider/user_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/themes/app_font.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentIndex;
  PageController pageController;
  final _pageOptions = [
    HomePage(),
    AccountPage(),
    SettingPage(),
  ];

  @override
  void initState() {
    currentIndex = 0;
    pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookProvider>(context, listen: false).fetchAll();
      Provider.of<BookProvider>(context, listen: false).fetchRecommended();
      Provider.of<ChapterProvider>(context, listen: false).fetchAll();
      Provider.of<UserProvider>(context, listen: false).fetchAll();
      Provider.of<BookmarkProvider>(context, listen: false).fetchAll();
      Provider.of<LanguageProvider>(context, listen: false).fetchAll();
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<BookProvider, LanguageProvider>(
      builder: (context, bookProvider, languageProvider, _) => WillPopScope(
        onWillPop: onCloseApp,
        child: Scaffold(
          body: SizedBox.expand(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (index) {
                setState(() => currentIndex = index);
              },
              children: <Widget>[
                _pageOptions[0],
                _pageOptions[1],
                _pageOptions[2],
              ],
            ),
          ),
          bottomNavigationBar: (Platform.isIOS)
              ? BottomNavigationBar(
                  backgroundColor: secondaryColor,
                  currentIndex: currentIndex,
                  onTap: (index) {
                    setState(() => currentIndex = index);
                    pageController.jumpToPage(index);
                  },
                  unselectedItemColor: Colors.black.withOpacity(0.65),
                  selectedItemColor: Colors.blue,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_outlined,
                        size: medium,
                      ),
                      label: languageProvider.language ? enHome : inaHome,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.account_circle_outlined,
                        size: medium,
                      ),
                      label: languageProvider.language ? enAccount : inaAccount,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.settings_outlined,
                        size: medium,
                      ),
                      label: languageProvider.language ? enSetting : inaSetting,
                    ),
                  ],
                )
              : BottomNavyBar(
                  backgroundColor: secondaryColor,
                  selectedIndex: currentIndex,
                  onItemSelected: (index) {
                    setState(() => currentIndex = index);
                    pageController.jumpToPage(index);
                  },
                  showElevation: true,
                  items: [
                    BottomNavyBarItem(
                      icon: Icon(
                        Icons.home_outlined,
                        size: medium,
                      ),
                      title: Text(
                        languageProvider.language ? enHome : inaHome,
                        style: GoogleFonts.roboto(
                          fontWeight: fontRegular,
                          fontSize: small,
                        ),
                      ),
                      activeColor: primaryLevelColor,
                    ),
                    BottomNavyBarItem(
                      icon: Icon(
                        Icons.account_circle_outlined,
                        size: medium,
                      ),
                      title: Text(
                        languageProvider.language ? enAccount : inaAccount,
                        style: GoogleFonts.roboto(
                          fontWeight: fontRegular,
                          fontSize: small,
                        ),
                      ),
                      activeColor: juniorLevelColor,
                    ),
                    BottomNavyBarItem(
                      icon: Icon(
                        Icons.settings_outlined,
                        size: medium,
                      ),
                      title: Text(
                        languageProvider.language ? enSetting : inaSetting,
                        style: GoogleFonts.roboto(
                          fontWeight: fontRegular,
                          fontSize: small,
                        ),
                      ),
                      activeColor: primaryTextColor,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<bool> onCloseApp() async {
    return (await showDialog(
          context: context,
          builder: (_) => Consumer2<UserProvider, LanguageProvider>(
            builder: (context, userProvider, languageProvider, _) {
              return (Platform.isIOS)
                  ? CupertinoAlertDialog(
                      title: CustomText(
                        text: languageProvider.language
                            ? enCloseApp
                            : inaCloseApp,
                        size: regular,
                        color: Colors.blue,
                      ),
                      content: CustomText(
                        text: languageProvider.language
                            ? enNotifClose
                            : inaNotifClose,
                        maxLine: 2,
                        size: normal,
                        color: primaryTextColor,
                      ),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: CustomText(
                            text: languageProvider.language ? enNo : inaNo,
                            size: normal,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          child: CustomText(
                            text: languageProvider.language ? enYes : inaYes,
                            size: normal,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            SystemChannels.platform
                                .invokeMethod('SystemNavigator.pop');
                          },
                        ),
                      ],
                    )
                  : AlertDialog(
                      title: CustomText(
                        text: languageProvider.language
                            ? enCloseApp
                            : inaCloseApp,
                        size: regular,
                        color: primaryColor,
                      ),
                      content: CustomText(
                        text: languageProvider.language
                            ? enNotifClose
                            : inaNotifClose,
                        maxLine: 2,
                        size: normal,
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: CustomText(
                            text: languageProvider.language ? enNo : inaNo,
                            size: normal,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: CustomText(
                            text: languageProvider.language ? enYes : inaYes,
                            size: normal,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            SystemChannels.platform
                                .invokeMethod('SystemNavigator.pop');
                          },
                        ),
                      ],
                    );
            },
          ),
        ) ??
        false);
  }
}
