import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/custom_text.dart';
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
                color: primaryColor,
                borderRadius: BorderRadius.circular(
                  radiusSmall,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: paddingSmall,
              ),
              child: CircleAvatar(
                radius: radiusMedium - 0.5,
                backgroundColor: secondaryColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: paddingSmall + 7,
              ),
              child: Image.asset(
                'assets/images/tutwuri.png',
                height: 75,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: paddingSmall + 90 + paddingSmall,
              ),
              child: CustomText(
                text: 'Pusat Kurikulum dan Perbukuan\n\nKEMENDIKBUD',
                color: secondaryTextColor,
                size: regular,
              ),
            ),
          )
        ],
      ),
    );
  }
}
