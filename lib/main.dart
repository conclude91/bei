import 'package:bei/pages/bookshelf_page.dart';
import 'package:bei/pages/explore_page.dart';
import 'package:bei/pages/home_page.dart';
import 'package:bei/pages/setting_page.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/provider/chapter_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_string.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookProvider()),
        ChangeNotifierProvider(create: (context) => ChapterProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppString.appName,
        theme: ThemeData(
          primaryColor: AppColor.primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<BookProvider>(
          builder: (context, bookProvider, _) => Scaffold(
            body: SizedBox.expand(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                children: <Widget>[
                  HomePage(),
                  ExplorePage(),
                  BookShelfPage(),
                  SettingPage(),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavyBar(
              backgroundColor: AppColor.secondaryColor,
              selectedIndex: currentIndex,
              onItemSelected: (index) {
                setState(() => currentIndex = index);
                pageController.jumpToPage(index);
              },
              showElevation: true,
              items: [
                BottomNavyBarItem(
                  icon: Icon(Icons.home),
                  title: Text(bookProvider.isSwitch
                        ? 'Beranda'
                        : 'Home'),
                  activeColor: AppColor.primaryLevel,
                ),
                BottomNavyBarItem(
                    icon: Icon(Icons.explore),
                    title: Text(bookProvider.isSwitch
                        ? 'Jelajahi'
                        : 'Explore'),
                    activeColor: AppColor.juniorLevel),
                BottomNavyBarItem(
                    icon: Icon(Icons.menu_book_rounded),
                    title: Text(bookProvider.isSwitch
                        ? 'Rak Buku'
                        : 'Bookshelf'),
                    activeColor: AppColor.seniorLevel),
                BottomNavyBarItem(
                    icon: Icon(Icons.settings),
                    title: Text(bookProvider.isSwitch
                        ? 'Pengaturan'
                        : 'Settings'),
                    activeColor: AppColor.primaryTextColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
