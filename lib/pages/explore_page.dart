import 'package:bei/provider/book_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/card_school.dart';
import 'package:bei/widgets/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, _) => Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Container(
          padding: EdgeInsets.only(
            top: AppDimen.paddingNormal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: AppDimen.appBarHeight,
                color: AppColor.backgroundColor,
                child: Center(
                  child: PrimaryText(
                    text: bookProvider.isSwitch ? 'Jelajahi' : 'Explore',
                    size: AppDimen.regular,
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: AppColor.primaryColor,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(
                    top: 0,
                  ),
                  shrinkWrap: true,
                  children: [
                    CardSchool(
                      level: 'SD',
                    ),
                    SizedBox(
                      height: AppDimen.paddingSmall,
                    ),
                    CardSchool(
                      level: 'SMP',
                    ),
                    SizedBox(
                      height: AppDimen.paddingSmall,
                    ),
                    CardSchool(
                      level: 'SMA',
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
