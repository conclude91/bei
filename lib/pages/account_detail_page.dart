import 'package:bei/consts/constanta.dart';
import 'package:bei/provider/user_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/themes/app_font.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AccountDetailPage extends StatefulWidget {
  @override
  _AccountDetailPageState createState() => _AccountDetailPageState();
}

enum Gender { L, P }

class _AccountDetailPageState extends State<AccountDetailPage> {
  DateTime selectedDate;
  DateFormat dateFormat;
  TextEditingController nameController;
  TextEditingController usernameController;
  TextEditingController emailController;
  TextEditingController genderController;
  TextEditingController birthdayController;
  TextEditingController cityController;
  TextEditingController addressController;
  TextEditingController phoneController;
  Gender gender;

  @override
  void initState() {
    selectedDate = DateTime.now();
    dateFormat = DateFormat('yyyy-MM-dd');
    nameController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    birthdayController = TextEditingController();
    cityController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (nameController.text.isEmpty)
        nameController.text = userProvider.currentUser.name ?? '';
      if (emailController.text.isEmpty)
        emailController.text = userProvider.currentUser.email ?? '';
      if (usernameController.text.isEmpty)
        usernameController.text = userProvider.currentUser.username ?? '';
      if (cityController.text.isEmpty)
        cityController.text = userProvider.currentUser.city ?? '';
      if (addressController.text.isEmpty)
        addressController.text = userProvider.currentUser.address ?? '';
      if (phoneController.text.isEmpty)
        phoneController.text = userProvider.currentUser.phone ?? '';
      if (userProvider.currentUser.gender != null && gender == null) {
        if (userProvider.currentUser.gender == 'L') {
          gender = Gender.L;
        } else {
          gender = Gender.P;
        }
      }
      if (userProvider.currentUser.birthday != null &&
          dateFormat.format(selectedDate) ==
              dateFormat.format(DateTime.now())) {
        selectedDate = DateTime.parse(userProvider.currentUser.birthday);
      }

      return Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            top: paddingNormal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: appBarHeight,
                color: backgroundColor,
                padding: EdgeInsets.only(
                  left: paddingTiny - 6,
                  right: paddingTiny - 6,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(paddingTiny),
                        child: Icon(Icons.close),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    CustomText(
                      text: 'Account',
                      color: primaryTextColor,
                      size: regular,
                    ),
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(paddingTiny),
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      ),
                      onTap: () {
                        updateUser();
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: primaryColor,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(
                    top: 0,
                  ),
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: 150,
                      child: Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: backgroundColor,
                          child: CircleAvatar(
                            radius: 59,
                            backgroundColor: disableColor,
                            backgroundImage:
                                userProvider.currentUser.gender != null
                                    ? userProvider.currentUser.gender == 'L'
                                        ? AssetImage('assets/images/male.png')
                                        : AssetImage('assets/images/female.png')
                                    : AssetImage('assets/images/male.png'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: paddingSmall,
                        right: paddingSmall,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomText(
                            text: 'Name',
                            color: primaryColor,
                            size: tiny,
                          ),
                          Container(
                            height: 30,
                            child: TextField(
                              controller: nameController,
                              style: GoogleFonts.roboto(
                                color: primaryTextColor,
                                fontWeight: fontlight,
                                fontSize: normal,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  bottom: 18,
                                ),
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: primaryTextColor,
                          ),
                          SizedBox(
                            height: paddingSmall,
                          ),
                          CustomText(
                            text: 'Username',
                            color: primaryColor,
                            size: tiny,
                          ),
                          Container(
                            height: 30,
                            child: TextField(
                              controller: usernameController,
                              style: GoogleFonts.roboto(
                                color: primaryTextColor,
                                fontWeight: fontlight,
                                fontSize: normal,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  bottom: 18,
                                ),
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: primaryTextColor,
                          ),
                          SizedBox(
                            height: paddingSmall,
                          ),
                          CustomText(
                            text: 'Email',
                            color: primaryColor,
                            size: tiny,
                          ),
                          Container(
                            height: 30,
                            child: TextField(
                              controller: emailController,
                              readOnly: true,
                              style: GoogleFonts.roboto(
                                color: primaryTextColor,
                                fontWeight: fontlight,
                                fontSize: normal,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  bottom: 18,
                                ),
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: primaryTextColor,
                          ),
                          SizedBox(
                            height: paddingSmall,
                          ),
                          CustomText(
                            text: 'Gender',
                            color: primaryColor,
                            size: tiny,
                          ),
                          Container(
                            height: 45,
                            child: Row(
                              children: [
                                Radio(
                                  value: Gender.L,
                                  groupValue: gender,
                                  onChanged: (Gender value) {
                                    setState(() {
                                      gender = value;
                                    });
                                  },
                                ),
                                CustomText(
                                  text: 'Male',
                                  color: primaryTextColor,
                                  size: small,
                                ),
                                Radio(
                                  value: Gender.P,
                                  groupValue: gender,
                                  onChanged: (Gender value) {
                                    setState(() {
                                      gender = value;
                                    });
                                  },
                                ),
                                CustomText(
                                  text: 'Female',
                                  color: primaryTextColor,
                                  size: small,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: paddingTiny,
                          ),
                          CustomText(
                            text: 'Birthday',
                            color: primaryColor,
                            size: tiny,
                          ),
                          InkWell(
                            child: Container(
                              height: 30,
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                text: dateFormat.format(selectedDate) !=
                                        dateFormat.format(DateTime.now())
                                    ? dateFormat.format(selectedDate)
                                    : '',
                                color: primaryTextColor,
                                size: normal,
                              ),
                            ),
                            onTap: () {
                              showDate();
                            },
                          ),
                          Divider(
                            height: 1,
                            color: primaryTextColor,
                          ),
                          SizedBox(
                            height: paddingSmall,
                          ),
                          CustomText(
                            text: 'City',
                            color: primaryColor,
                            size: tiny,
                          ),
                          Container(
                            height: 30,
                            child: TextField(
                              controller: cityController,
                              style: GoogleFonts.roboto(
                                color: primaryTextColor,
                                fontWeight: fontlight,
                                fontSize: normal,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  bottom: 18,
                                ),
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: primaryTextColor,
                          ),
                          SizedBox(
                            height: paddingSmall,
                          ),
                          CustomText(
                            text: 'Address',
                            color: primaryColor,
                            size: tiny,
                          ),
                          Container(
                            height: 30,
                            child: TextField(
                              controller: addressController,
                              style: GoogleFonts.roboto(
                                color: primaryTextColor,
                                fontWeight: fontlight,
                                fontSize: normal,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  bottom: 18,
                                ),
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: primaryTextColor,
                          ),
                          SizedBox(
                            height: paddingSmall,
                          ),
                          CustomText(
                            text: 'Phone',
                            color: primaryColor,
                            size: tiny,
                          ),
                          Container(
                            height: 30,
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.roboto(
                                color: primaryTextColor,
                                fontWeight: fontlight,
                                fontSize: normal,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  bottom: 18,
                                ),
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: primaryTextColor,
                          ),
                          SizedBox(
                            height: paddingSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  showDate() async {
    final datePick = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year - 40),
      lastDate: DateTime.now(),
    );

    if (datePick != null) {
      setState(() {
        print(datePick);
        selectedDate = datePick;
      });
    }
  }

  updateUser() async {
    var request =
        http.MultipartRequest('POST', Uri.parse(Constanta.UPDATE_USER));
    request.fields.addAll({
      'id': '481',
      'email': emailController.text,
      'name': nameController.text,
      'username': usernameController.text,
      'avatar': '',
      'phone': phoneController.text,
      'address': addressController.text,
      'birthday': dateFormat.format(selectedDate),
      'city': cityController.text,
      'gender': gender.toString().split('.').last,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: 'User data has been updated',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      Provider.of<UserProvider>(context, listen: false).fecthAll();
      Provider.of<UserProvider>(context, listen: false).currentUser;
      Navigator.pop(context);
    } else {
      print(response.reasonPhrase);
      Fluttertoast.showToast(
        msg: 'Update data failed',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }
}
