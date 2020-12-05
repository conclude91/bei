import 'package:bei/pages/account_page.dart';
import 'package:bei/pages/home_page.dart';
import 'package:bei/pages/setting_page.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/themes/app_font.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentIndex;
  PageController pageController;
  @override
  void initState() {
    currentIndex = 0;
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, _) => Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            children: <Widget>[
              HomePage(),
              AccountPage(),
              SettingPage(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
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
                bookProvider.isSwitch ? 'Beranda' : 'Home',
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
                bookProvider.isSwitch ? 'Akun' : 'Account',
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
                  bookProvider.isSwitch ? 'Pengaturan' : 'Settings',
                  style: GoogleFonts.roboto(
                    fontWeight: fontRegular,
                    fontSize: small,
                  ),
                ),
                activeColor: primaryTextColor),
          ],
        ),
      ),
    );
  }
}
