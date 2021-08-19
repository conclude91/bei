import 'dart:io';

import 'package:bei/provider/language_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/values/app_string.dart';
import 'package:bei/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  List<bool> listItem;

  @override
  void initState() {
    listItem = List.filled(15, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) => Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: appBarHeight,
                color: backgroundColor,
                child: Stack(
                  children: [
                    (Platform.isIOS)
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(
                                left: paddingTiny,
                              ),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios_outlined,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      languageProvider.language
                                          ? enBack
                                          : inaBack,
                                      style: TextStyle(
                                        fontSize: normal,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(
                                left: paddingTiny,
                                right: paddingTiny,
                              ),
                              child: InkWell(
                                child: Padding(
                                  padding: EdgeInsets.all(paddingTiny),
                                  child: Icon(
                                    Icons.arrow_back,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: languageProvider.language ? enFAQ : inaFAQ,
                        size: regular,
                      ),
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
                  padding: EdgeInsets.only(top: 0),
                  shrinkWrap: true,
                  children: [
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: languageProvider.language
                                  ? 'What is Bukunesia?'
                                  : 'Apa itu Bukunesia?',
                              size: normal,
                            ),
                            Icon(
                              listItem[0]
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          listItem[0] = !listItem[0];
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    Visibility(
                      visible: listItem[0] ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingSmall,
                              right: paddingSmall,
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            child: CustomText(
                              text: languageProvider.language
                                  ? 'Bukunesia is an application for digitally reading books that gives users access to books via mobile devices. Bukunesia provides digital-based textbooks.'
                                  : 'Bukunesia adalah aplikasi untuk membaca buku secara digital yang memberikan akses kepada penggunanya untuk dapat mengakses buku melalui mobile device. Bukunesia menyediakan buku pelajaran berbasis digital.',
                              size: small,
                              align: TextAlign.justify,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: disableTextColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: languageProvider.language
                                  ? 'Who can become Bukunesia users?'
                                  : 'Siapa saja yang bisa menjadi pengguna Bukunesia?',
                              size: normal,
                            ),
                            Icon(
                              listItem[1]
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          listItem[1] = !listItem[1];
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    Visibility(
                      visible: listItem[1] ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingSmall,
                              right: paddingSmall,
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            child: CustomText(
                              text: languageProvider.language
                                  ? 'School students from elementary to high school, teachers from elementary to high school as well as the general public who have a concern for increasing literacy levels in Indonesia. We are ready to support you!'
                                  : 'Siswa sekolah mulai SD sampai SMA, Guru mulai SD sampai SMA juga masyarakat umum yang memiliki kepedulian meningkatkan tingkat literasi di Indonesia. Kami siap mendukung anda!',
                              size: small,
                              align: TextAlign.justify,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: disableTextColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: languageProvider.language
                                  ? 'How to use the Bukunesia application?'
                                  : 'Bagaimana cara menggunakan aplikasi Bukunesia?',
                              size: normal,
                            ),
                            Icon(
                              listItem[2]
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          listItem[2] = !listItem[2];
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    Visibility(
                      visible: listItem[2] ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingSmall,
                              right: paddingSmall,
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            child: CustomText(
                              text: (Platform.isIOS)
                                  ? languageProvider.language
                                      ? 'Download Bukunesia on App Store, install the app and sign in with Apple.'
                                      : 'Unduh Bukunesia di App Store, instal aplikasi dan masuk dengan Apple.'
                                  : languageProvider.language
                                      ? 'Download Bukunesia on Play Store, install the app and sign in with Google.'
                                      : 'Unduh Bukunesia di Play Store, instal aplikasi dan masuk dengan Google.',
                              size: small,
                              align: TextAlign.justify,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: disableTextColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: languageProvider.language
                                  ? 'How to read a book in Bukunesia?'
                                  : 'Bagaimana cara membaca buku di Bukunesia?',
                              size: normal,
                            ),
                            Icon(
                              listItem[3]
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          listItem[3] = !listItem[3];
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    Visibility(
                      visible: listItem[3] ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingSmall,
                              right: paddingSmall,
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            child: CustomText(
                              text: languageProvider.language
                                  ? 'Click the cover or the book you want then you will be directed to the book details, then click the read button the application will display the desired book and chapter of the book that has been separated from the original book, then click the download button on the right, wait a few seconds for the download finished. The download button on the right will change to a checkmark indicating the book or file can be read.'
                                  : 'Klik cover atau buku yang di inginkan kemudian akan diarahkan ke detail buku, kemudian klik tombol baca aplikasi akan menampilkan Buku yang di inginkan  dan bab dari buku yang sudah di pisah dari buku asli, kemudian klik tombol unduh di sebelah kanan, tunggu beberapa detik hingga unduhan selesai. Tombol unduh yang disebelah kanan tadi akan berubah menjadi centang yang menandakan buku, atau file sudah bisa dibaca.',
                              size: small,
                              align: TextAlign.justify,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: disableTextColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: languageProvider.language
                                  ? 'How do i sign out of the Bukunesia application?'
                                  : 'Bagaimana cara keluar akun dari aplikasi Bukunesia?',
                              size: normal,
                            ),
                            Icon(
                              listItem[4]
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          listItem[4] = !listItem[4];
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    Visibility(
                      visible: listItem[4] ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingSmall,
                              right: paddingSmall,
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            child: CustomText(
                              text: languageProvider.language
                                  ? 'Click settings on the bottom right, then select sign out.'
                                  : 'Klik pengaturan di sebelah kanan bawah, kemudian pilih keluar akun.',
                              size: small,
                              align: TextAlign.justify,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: disableTextColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: languageProvider.language
                                  ? 'How to download the Bukunesia app'
                                  : 'Cara unduh aplikasi Bukunesia',
                              size: normal,
                            ),
                            Icon(
                              listItem[5]
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          listItem[5] = !listItem[5];
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    Visibility(
                      visible: listItem[5] ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingSmall,
                              right: paddingSmall,
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            child: CustomText(
                              text: (Platform.isIOS)
                                  ? languageProvider.language
                                      ? '1. Open the App Store\n2. Search Bukunesia\n3. Click the Get button on Bukunesia\n4. Enter your Apple ID'
                                      : '1.	Buka App Store\n2.	Cari Bukunesia\n3.	Klik tombol Dapatkan pada Bukunesia\n4.	Masukkan Apple ID Anda'
                                  : languageProvider.language
                                      ? '1. Go to Play Store\n2. Search Bukunesia\n3. Click the Install button on Bukunesia'
                                      : '1.	Buka Play Store\n2.	Cari Bukunesia\n3.	Klik tombol Pasang pada Bukunesia',
                              size: small,
                              align: TextAlign.justify,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: disableTextColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: languageProvider.language
                                  ? 'How to register an account'
                                  : 'Cara daftar akun',
                              size: normal,
                            ),
                            Icon(
                              listItem[6]
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          listItem[6] = !listItem[6];
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    Visibility(
                      visible: listItem[6] ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingSmall,
                              right: paddingSmall,
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            child: CustomText(
                              text: (Platform.isIOS)
                                  ? languageProvider.language
                                      ? '1. Tap the Bukunesia application and enter the application\n2. Tap or skip information about the application\n3. Tap the Sign in button in the lower right corner\n4. Tap the "Sign in with Apple" button at the bottom\n5. Select the your Apple Id and do password validation, click continue button\n6. After entering the homepage, complete your personal data, then click the save button in the upper right corner.\n7. Your account has been successfully registered completely.'
                                      : '1. Tap aplikasi Bukunesia dan masuk ke dalam aplikasi\n2.	Tap atau skip informasi mengenai aplikasi\n3.	Tap tombol Masuk di pojok kanan bawah\n4.	Tap tombol "Masuk dengan Apple" di bagian bawah\n5. Pilih akun Apple Id anda dan lakukan validasi password, tekan tombol continue\n6.	Setelah masuk beranda, isi data diri anda dengan lengkap, lalu klik tombol simpan di pojok kanan atas.\n7. Akun anda sudah berhasil terdaftar dengan lengkap'
                                  : languageProvider.language
                                      ? '1. Tap the Bukunesia application and enter the application\n2. Tap or skip information about the application\n3. Tap the Sign in button in the lower right corner\n4. Tap the "Sign in with Google" button at the bottom\n5. Select the Google you want to use\n6. After entering the homepage, complete your personal data, then click the save button in the upper right corner.\n7. Your account has been successfully registered completely.'
                                      : '1. Tap aplikasi Bukunesia dan masuk ke dalam aplikasi\n2.	Tap atau skip informasi mengenai aplikasi\n3.	Tap tombol Masuk di pojok kanan bawah\n4.	Tap tombol "Masuk dengan Google" di bagian bawah\n5. Pilih akun Google yang ingin digunakan\n6.	Setelah masuk beranda, isi data diri anda dengan lengkap, lalu klik tombol simpan di pojok kanan atas.\n7. Akun anda sudah berhasil terdaftar dengan lengkap.',
                              size: small,
                              align: TextAlign.justify,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: disableTextColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: languageProvider.language
                                  ? 'How to change profile data'
                                  : 'Cara merubah data profil',
                              size: normal,
                            ),
                            Icon(
                              listItem[7]
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          listItem[7] = !listItem[7];
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    Visibility(
                      visible: listItem[7] ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingSmall,
                              right: paddingSmall,
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            child: CustomText(
                              text: languageProvider.language
                                  ? '1. Tap the avatar symbol in the top right corner or go to the account menu in the main menu then select the edit symbol \n2. Change or adjust your personal data\n3. Then tap save button to save it'
                                  : '1. Tap simbol avatar pojok kanan atas atau masuk ke menu akun di menu utama kemudian pilih simbol edit \n2.	Rubah atau sesuaikan data diri anda\n3. Kemudian tap tombol simpan untuk menyimpannya',
                              size: small,
                              align: TextAlign.justify,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: disableTextColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: languageProvider.language
                                  ? 'How to read a book'
                                  : 'Cara membaca buku',
                              size: normal,
                            ),
                            Icon(
                              listItem[8]
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          listItem[8] = !listItem[8];
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    Visibility(
                      visible: listItem[8] ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingSmall,
                              right: paddingSmall,
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            child: CustomText(
                              text: languageProvider.language
                                  ? '1. Go to your dashboard or account page to select the book you want to read.\n2. Tap on the book you want to read.\n3. Go to the book details page and tap the Read button.\n4. Select the desired content, \n\• Content that has been downloaded on the right side will have a green tick symbol and can be read immediately\n\• Content that has not been downloaded on the right side will have a download symbol, which means the file must be downloaded before it can be read .\n5. For files that must be downloaded wait a few moments until the download is complete.\n6. When the download is complete the app will redirect to the newly downloaded file'
                                  : '1.Masuk ke halaman dashboard atau akun untuk memilih buku yang ingin dibaca.\n2. Tap pada buku yang ingin dibaca.\n3. Masuk kehalaman detail buku dan tap tombol Baca.\n4. Pilih konten yang dinginkan, \n\• Konten yang sudah di unduh di samping kanannya akan bersimbolkan Centang Hijau dan bisa langsung dibaca\n\• Konten yang belum diunduh di samping kanannya akan memiliki simbol unduh yang artinya file harus diunduh terlebih dahulu sebelum bisa dibaca.\n5. Untuk file yang harus di unduh tunggu beberapa saat hingga unduhan selesai.\n6. Ketika unduhan selesai aplikasi akan mengarahkan pada file yang baru diunduh',
                              size: small,
                              align: TextAlign.justify,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: disableTextColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: languageProvider.language
                                  ? 'How to search books'
                                  : 'Cara mencari buku',
                              size: normal,
                            ),
                            Icon(
                              listItem[9]
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          listItem[9] = !listItem[9];
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    Visibility(
                      visible: listItem[9] ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingSmall,
                              right: paddingSmall,
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            child: CustomText(
                              text: languageProvider.language
                                  ? '1. Enter the search feature.\n2. Type in keywords according to the book you are looking for or use filter sort to categorize according to the level, class, or scientific field you want to search for\n3. Select the book according to the desired search category.'
                                  : '1.	Masuk ke fitur pencarian.\n2.	Ketikan kata kunci sesuai buku yang dicari atau gunakan filter sort untuk mengkategorikan sesuai jenjang, kelas, atau bidang keilmuan yang ingin dicari\n3.	Pilih buku sesuai kategori pencarian yang diinginkan.',
                              size: small,
                              align: TextAlign.justify,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: disableTextColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: languageProvider.language
                                  ? 'How to print a book or page'
                                  : 'Cara print buku atau halaman',
                              size: normal,
                            ),
                            Icon(
                              listItem[10]
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          listItem[10] = !listItem[10];
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    Visibility(
                      visible: listItem[10] ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingSmall,
                              right: paddingSmall,
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            child: CustomText(
                              text: languageProvider.language
                                  ? '1. Go to the page of the book you have downloaded.\n2. Tap the print button in the upper right corner.\n3. Select the detected printer.\n4. Click print.'
                                  : '1.	Masuk ke halaman buku yang telah anda unduh.\n2.	Tap tombol print di pojok kanan atas.\n3.	Pilih printer yang terdeteksi.\n4. Klik print.',
                              size: small,
                              align: TextAlign.justify,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: disableTextColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: languageProvider.language
                                  ? 'How to bookmark a page'
                                  : 'Cara menandai halaman',
                              size: normal,
                            ),
                            Icon(
                              listItem[11]
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          listItem[11] = !listItem[11];
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    Visibility(
                      visible: listItem[11] ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingSmall,
                              right: paddingSmall,
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            child: CustomText(
                              text: languageProvider.language
                                  ? '1. Go to the page of the book you have downloaded.\n2. Tap the bookmark button in the top right corner.\n3. Select a bookmark on the page you want to bookmark'
                                  : '1.	Masuk ke halaman buku yang telah anda unduh.\n2.	Tap tombol bookmark di pojok kanan atas.\n3.	Pilih bookmark di halaman yang ingin anda tandai',
                              size: small,
                              align: TextAlign.justify,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: disableTextColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: languageProvider.language
                                  ? 'How to read bookmarked book pages'
                                  : 'Cara membaca halaman buku yang ditandai',
                              size: normal,
                            ),
                            Icon(
                              listItem[12]
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          listItem[12] = !listItem[12];
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    Visibility(
                      visible: listItem[12] ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingSmall,
                              right: paddingSmall,
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            child: CustomText(
                              text: languageProvider.language
                                  ? '1. Enter the account page\n2. Tap the bookmark symbol on the right parallel to the avatar photo.\n3. Select a bookmarked page to read.'
                                  : '1.	Masuk halaman akun\n2. Tap simbol bookmark disebelah kanan sejajar dengan foto avatar.\n3.	Pilih halaman bookmark yang akan dibaca.',
                              size: small,
                              align: TextAlign.justify,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: disableTextColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: languageProvider.language
                                  ? 'How to change app language'
                                  : 'Cara merubah bahasa aplikasi',
                              size: normal,
                            ),
                            Icon(
                              listItem[13]
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          listItem[13] = !listItem[13];
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    Visibility(
                      visible: listItem[13] ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingSmall,
                              right: paddingSmall,
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            child: CustomText(
                              text: languageProvider.language
                                  ? '1. Enter the settings page\n2. Select language\n3. Select the desired language'
                                  : '1.	Masuk halaman setting\n2. Pilih bahasa\n3.	Pilih bahasa yang diinginkan',
                              size: small,
                              align: TextAlign.justify,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: disableTextColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(
                          left: paddingSmall,
                          right: paddingSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: languageProvider.language
                                  ? 'Complaints against book content'
                                  : 'Pengaduan terhadap konten buku',
                              size: normal,
                            ),
                            Icon(
                              listItem[14]
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          listItem[14] = !listItem[14];
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      color: disableTextColor,
                    ),
                    Visibility(
                      visible: listItem[14] ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: paddingSmall,
                              right: paddingSmall,
                              top: paddingTiny,
                              bottom: paddingTiny,
                            ),
                            child: CustomText(
                              text: languageProvider.language
                                  ? '1. Tap the exclamation mark icon in the upper right corner\n2. Fill in the title of the book and the message of the complaint\n3. Tap the send button\n4. Your complaint will be sent and will be processed by the Center for Curriculum and Books'
                                  : '1.	Tap icon tanda seru di pojok kanan atas\n2.	Isi judul bukunya dan pesan keluhannya\n3.	Tap tombol kirim\n4.	Keluhan anda akan terkirim dan akan di proses oleh pihak Pusat Kurikulum Dan Perbukuan',
                              size: small,
                              align: TextAlign.justify,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: disableTextColor,
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
      ),
    );
  }
}
