import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/secondary_text.dart';
import 'package:flutter/material.dart';

class PlaceHolder extends StatefulWidget {
  @override
  _PlaceHolderState createState() => _PlaceHolderState();
}

class _PlaceHolderState extends State<PlaceHolder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 125,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(
                  AppDimen.radiusSmall,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: AppDimen.paddingSmall,
              ),
              child: SecondaryText(
                text: 'Your\nBookshelf',
                size: AppDimen.medium,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: AppDimen.paddingSmall,
                bottom: AppDimen.paddingNormal + 5,
              ),
              child: CircleAvatar(
                backgroundColor: AppColor.primaryColor,
                radius: AppDimen.radiusMedium,
                child: CircleAvatar(
                  radius: AppDimen.radiusMedium - 0.5,
                  backgroundColor: AppColor.secondaryColor,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: AppDimen.paddingSmall,
              ),
              child: Image.asset(
                'assets/images/people-read.png',
                height: 75,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
