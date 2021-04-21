import 'dart:convert';
import 'dart:io';

import 'package:bei/consts/constanta.dart';
import 'package:bei/provider/language_provider.dart';
import 'package:bei/provider/user_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/themes/app_font.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
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
  TextEditingController schoolController;
  Gender gender;
  int roleId;
  File image;
  ImagePicker picker;
  String base64Image;

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
    schoolController = TextEditingController();
    picker = ImagePicker();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, LanguageProvider>(
        builder: (context, userProvider, languageProvider, _) {
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
      if (schoolController.text.isEmpty)
        schoolController.text = userProvider.currentUser.school ?? '';
      if (userProvider.currentUser.gender != null && gender == null) {
        if (userProvider.currentUser.gender == 'L') {
          gender = Gender.L;
        } else {
          gender = Gender.P;
        }
      }
      if (userProvider.currentUser.roleId != null && roleId == null) {
        if (userProvider.currentUser.roleId == 4) {
          roleId = 4;
        } else {
          roleId = 6;
        }
      }
      if (userProvider.currentUser.birthday != null &&
          dateFormat.format(selectedDate) ==
              dateFormat.format(DateTime.now())) {
        selectedDate = DateTime.parse(userProvider.currentUser.birthday);
      }

      return Scaffold(
        body: Container(
          color: backgroundColor,
          padding: EdgeInsets.only(
            top: Platform.isIOS ? paddingMedium : paddingNormal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: appBarHeight,
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
                      text: languageProvider.language ? enAccount : inaAccount,
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
                        updateUser(userProvider.currentUser.id);
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
                        child: InkWell(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: backgroundColor,
                            child: CircleAvatar(
                              radius: 59,
                              backgroundColor: disableColor,
                              backgroundImage: image != null
                                  ? FileImage(image)
                                  : userProvider.currentUser.avatar != null &&
                                          userProvider.currentUser.avatar !=
                                              'avatar'
                                      ? NetworkImage(
                                          userProvider.currentUser.avatar)
                                      : userProvider.currentUser.gender != null
                                          ? userProvider.currentUser.gender ==
                                                  'L'
                                              ? AssetImage(
                                                  'assets/images/male.png')
                                              : AssetImage(
                                                  'assets/images/female.png')
                                          : AssetImage(
                                              'assets/images/male.png'),
                            ),
                          ),
                          onTap: () {
                            getImage();
                          },
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
                            text: languageProvider.language ? enName : inaName,
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
                            text: languageProvider.language
                                ? enUsername
                                : inaUsername,
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
                            text:
                                languageProvider.language ? enEmail : inaEmail,
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
                            text: languageProvider.language
                                ? enGender
                                : inaGender,
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
                                  text: languageProvider.language
                                      ? enMale
                                      : inaMale,
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
                                  text: languageProvider.language
                                      ? enFemale
                                      : inaFemale,
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
                            text: languageProvider.language
                                ? enBirthday
                                : inaBirthday,
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
                            text: languageProvider.language ? enCity : inaCity,
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
                            text: languageProvider.language
                                ? enAddress
                                : inaAddress,
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
                            text:
                                languageProvider.language ? enPhone : inaPhone,
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
                          CustomText(
                            text: languageProvider.language
                                ? enUserType
                                : inaUserType,
                            color: primaryColor,
                            size: tiny,
                          ),
                          Container(
                            height: 45,
                            child: Row(
                              children: [
                                Radio(
                                  value: 4,
                                  groupValue: roleId,
                                  onChanged: (value) {
                                    setState(() {
                                      roleId = value;
                                    });
                                  },
                                ),
                                CustomText(
                                  text: languageProvider.language
                                      ? enStudent
                                      : inaStudent,
                                  color: primaryTextColor,
                                  size: small,
                                ),
                                Radio(
                                  value: 6,
                                  groupValue: roleId,
                                  onChanged: (value) {
                                    setState(() {
                                      roleId = value;
                                    });
                                  },
                                ),
                                CustomText(
                                  text: languageProvider.language
                                      ? enTeacher
                                      : inaTeacher,
                                  color: primaryTextColor,
                                  size: small,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: paddingSmall,
                          ),
                          CustomText(
                            text: languageProvider.language
                                ? enSchool
                                : inaSchool,
                            color: primaryColor,
                            size: tiny,
                          ),
                          Container(
                            height: 30,
                            child: TextField(
                              controller: schoolController,
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
        selectedDate = datePick;
      });
    }
  }

  updateUser(int id) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(Constanta.UPDATE_USER));
    uploadImage(id);
    request.fields.addAll({
      'id': id.toString(),
      'email': emailController.text,
      'name': nameController.text,
      'username': usernameController.text,
      'avatar': image != null
          ? Constanta.GET_IMAGE_USER +
              id.toString() +
              '.jpg?millis=' +
              DateTime.now().millisecondsSinceEpoch.toString()
          : 'avatar',
      'phone': phoneController.text,
      'address': addressController.text,
      'birthday': dateFormat.format(selectedDate),
      'city': cityController.text,
      'gender': gender.toString().split('.').last,
      'role_id': roleId.toString(),
      'school': schoolController.text,
    });

    await request.send().then((response) {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: Provider.of<LanguageProvider>(context, listen: false).language
              ? enSuccessUpdateUser
              : inaSuccessUpdateUser,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
        );
        deleteFile('Pictures');
        Provider.of<UserProvider>(context, listen: false).fetchAll();
        Provider.of<UserProvider>(context, listen: false).currentUser;
        Navigator.pop(context);
      } else {
        print(response.reasonPhrase);
        Fluttertoast.showToast(
          msg: Provider.of<LanguageProvider>(context, listen: false).language
              ? enFailedUpdateUser
              : inaFailedUpdateUser,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
        );
      }
    });
  }

  imgFromCamera() async {
    PickedFile pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        base64Image = base64Encode(image.readAsBytesSync());
      });
    }
  }

  imgFromGallery() async {
    PickedFile pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        base64Image = base64Encode(image.readAsBytesSync());
      });
    }
  }

  getImage() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Consumer<LanguageProvider>(
          builder: (context, languageProvider, _) => SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(
                        Icons.photo_library,
                        color: primaryTextColor,
                      ),
                      title: CustomText(
                          text: languageProvider.language
                              ? enGallery
                              : inaGallery,
                          size: normal),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(
                      Icons.photo_camera,
                      color: primaryTextColor,
                    ),
                    title: CustomText(
                        text: languageProvider.language ? enCamera : inaCamera,
                        size: normal),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  deleteFile(String path) async {
    Directory dir = await getApplicationDocumentsDirectory();
    final targetFile = Directory(dir.path + '/' + path);
    if (targetFile.existsSync()) {
      targetFile.deleteSync(recursive: true);
    }
  }

  uploadImage(int userId) {
    if (image != null) {
      String extension = p.extension(image.path);
      String fileName = userId.toString() + extension;
      http.post(Uri.parse(Constanta.UPLOAD_IMAGE_USER), body: {
        "image": base64Image,
        "name": fileName,
      }).then((response) {
        response.statusCode == 200
            ? print(response.body)
            : print('Error uploading file');
      }).catchError((error) {
        print(error);
      });
    }
  }
}
