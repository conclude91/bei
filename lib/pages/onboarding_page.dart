import 'package:bei/pages/signin_page.dart';
import 'package:bei/provider/language_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/themes/app_font.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  List<Widget> slider;
  int currentIndex;
  PageController pageController;

  @override
  void initState() {
    currentIndex = 0;
    pageController = PageController();
    bool language = context.read<LanguageProvider>().language;
    slider = <Widget>[
      showPage(
          AssetImage('assets/images/graphic-1.png'),
          language ? enTitleOnboarding1 : inaTitleOnboarding1,
          language ? enOnboarding1 : inaOnboarding1),
      showPage(
          AssetImage('assets/images/graphic-2.png'),
          language ? enTitleOnboarding2 : inaTitleOnboarding2,
          language ? enOnboarding2 : inaOnboarding2),
    ];
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) => Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            left: paddingSmall,
            right: paddingSmall,
          ),
          child: Stack(
            children: [
              PageView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                controller: pageController,
                itemCount: slider.length,
                itemBuilder: (context, index) {
                  return slider[index % slider.length];
                },
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: paddingSmall,
                    top: paddingSmall,
                  ),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: slider.length,
                    effect: WormEffect(
                      dotWidth: 5,
                      dotHeight: 5,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: currentIndex == 0 ? true : false,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: paddingSmall,
                        right: paddingSmall,
                        top: paddingSmall,
                        bottom: paddingSmall,
                      ),
                      margin: EdgeInsets.only(
                        bottom: paddingTiny,
                      ),
                      child: CustomText(
                        text: languageProvider.language ? enSkip : inaSkip,
                        size: normal,
                        color: primaryColor,
                        weight: fontRegular,
                      ),
                    ),
                    onTap: () {
                      setState(() => currentIndex = slider.length - 1);
                      pageController.jumpToPage(slider.length - 1);
                    },
                  ),
                ),
              ),
              Visibility(
                visible: currentIndex == slider.length - 1 ? true : false,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: paddingSmall,
                        right: paddingSmall,
                        top: paddingSmall,
                        bottom: paddingSmall,
                      ),
                      margin: EdgeInsets.only(
                        bottom: paddingTiny,
                      ),
                      child: CustomText(
                        text: languageProvider.language ? enSignIn : inaSignIn,
                        size: normal,
                        color: primaryColor,
                        weight: fontRegular,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInPage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack showPage(
    ImageProvider pict,
    String title,
    String desc,
  ) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  child: Image(
                    image: pict,
                    fit: BoxFit.fitHeight,
                    height: 230,
                    width: 230,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(
                    left: 15,
                    top: paddingMedium,
                    right: 15,
                    bottom: 10,
                  ),
                  child: CustomText(
                    text: title,
                    size: regular,
                    color: primaryColor,
                    weight: fontRegular,
                  ),
                ),
              ),
              SizedBox(
                height: paddingSmall,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: CustomText(
                    text: desc,
                    maxLine: 5,
                    size: normal,
                    color: primaryTextColor,
                    align: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
