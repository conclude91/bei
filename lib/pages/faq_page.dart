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
        body: Container(
          color: backgroundColor,
          padding: EdgeInsets.only(
            top: paddingNormal,
          ),
          child: Column(
            children: [
              Container(
                height: appBarHeight,
                color: backgroundColor,
                child: Stack(
                  children: [
                    Align(
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
                              text: 'Apa itu Bukunesia ?',
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
                              text:
                                  'Bukunesia adalah aplikasi untuk membaca buku secara digital yang memberikan akses kepada penggunanya untuk dapat mengakses buku melalui mobile Device. Bukunesia menyediakan Buku Pelajaran bacaan digital berupa buku. Layanan Bukunesia dapat diakses melalui perangkat smartphone berbasis iOS dan Android.',
                              size: small,
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
                              text:
                                  'Siapa saja yang bisa menjadi pengguna Bukunesia ?',
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
                              text:
                                  'Siswa sekolah mulai SD sampai SMA, Guru mulai SD sampai SMA juga masyarakat umum yang memiliki kepedulian meningkatkan tingkat literasi di Indonesia. Kami siap mendukung Anda!',
                              size: small,
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
                              text:
                                  'Bagaimana cara menggunakan aplikasi Bukunesia ?',
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
                              text:
                                  'Unduh aplikasi di Marketplace (Playstore / Appstore), Instal aplikasi dan masuk menggunakan akun Google.',
                              size: small,
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
                              text: 'Bagaimana cara membaca di aplikasi ?',
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
                              text:
                                  'Klik cover atau buku yang di inginkan kemudian akan diarahkan ke detail buku, kemudian klik tombol baca aplikasi akan menampilkan Buku yang di inginkan  dan BAB dari buku yang sudah di pisah dari buku asli, kemudian klik tombol unduh di sebelah kanan, tunggu beberapa detik hingga unduhan selesai, tombol unduh yang disebelah kanan tadi akan berubah menjadi centang yang menandakan buku, atau file sudah bisa dibaca.',
                              size: small,
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
                              text: 'Bagaimana keluar dari aplikasi ?',
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
                              text:
                                  'Klik pengaturan di sebelah kanan bawah, kemudian pilih keluar.',
                              size: small,
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
                              text: 'Cara unduh aplikasi Bukunesia',
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
                              text:
                                  'Android\n1.	Buka Play Store\n2.	Search Bukunesia\n3.	Klik tombol Pasang pada Bukunesia\n\niOS\n1.	Buka App Store\n2.	Search Bukunesia\n3.	Klik tombol Dapatkan pada Bukunesia\n4.	Masukkan Apple ID Anda',
                              size: small,
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
                              text: 'Cara daftar akun',
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
                              text:
                                  'Android/iOS\n1.	Tap Aplikasi Bukunesia dan masuk ke dalam aplikasi\n2.	Tap atau Skip informasi mengenai aplikasi\n3.	Tap Tombol Sign In di pojok kanan bawah\n4.	Tap Tombol “Sambungkan Dengan Akun Google” di bagian bawah\n5.	Pilih akun Google yang ingin digunakan\n6.	Isi data diri Anda (Nama Lengkap, Nama Pengguna, jenis Kelamin, Tanggal Lahir, Kota, Alamat, Telepon). Di icon avatar pojok kanan atas kemudian kelik tombol centang di pojok kanan atas.\n7.	Anda sudah bisa menikmati dan memanfaatkan Aplikasi Bukunesia.',
                              size: small,
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
                              text: 'Cara merubah profil',
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
                              text:
                                  '1.	Tap symbol avatar pojok kanan atas atau masuk ke menu akun di menu utama kemudian pilih symbol edit \n2.	Rubah atau sesuaikan data diri anda\n3.	Kemudian tap symbol centang hijau untuk menyimpannya\n4.	Atau sambal silang untuk membatalkan.',
                              size: small,
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
                              text: 'Cara membaca buku',
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
                              text:
                                  'Android & IOS\n1.	Pasang Aplikasi Bukunesia di perangkat Anda\n2.	Buka Aplikasi Bukunesia yang sudah dipasang di perangkat Anda\n3.	Masuk dengan menggunakan akun Google Anda.\n4.	Masuk ke halaman dashboard atau akun untuk memilih buku yang ingin dibaca.\n5.	Tap pada buku yang ingin dibaca.\n6.	Masuk kehalaman detail buku dan tap tombol Baca.\n7.	Pilih konten yang dinginkan, \n\•	Konten yang sudah di unduh di samping kanannya akan bersimbolkan Centang Hijau dan bisa langsung dibaca\n\•	Konten yang belum diunduh di samping kanannya akan memiliki simbol Unduh yang artinya file harus diunduh terlebih dahulu sebelum bisa dibaca.\n8.	Untuk File yang harus di unduh Tunggu beberapa saat hingga unduhan selesai.\n9.	Ketika unduhan selesai aplikasi akan mengarahkan pada file yang baru diunduh',
                              size: small,
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
                              text: 'Cara mencari buku',
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
                              text:
                                  '1.	Masuk ke Fitur Pencarian.\n2.	Ketikan Keyword sesuai buku yang dicari atau gunakan filter sort untuk mengkategorikan sesuai Jenjang, Kelas, atau bidang keilmuan yang ingin kita cari\n3.	Pilih buku sesuai kategori pencarian yang diinginkan. ',
                              size: small,
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
                              text: 'Cara print buku atau halaman',
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
                              text:
                                  '1.	Masuk ke halaman buku yang telah anda unduh.\n2.	Tap tombol Print di pojok kanan atas.\n3.	Pilih Printer yang terdeteksi.\n4.	Klik Print.',
                              size: small,
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
                              text: 'Cara menandai buku atau halaman',
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
                              text:
                                  '1.	Masuk ke halaman buku yang telah anda unduh.\n2.	Tap tombol Bookmark di pojok kanan atas.\n3.	Pilih Bookmart dihalaman yang ingin anda tandai',
                              size: small,
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
                              text: 'Cara membaca buku yang ditandai',
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
                              text:
                                  '1.	Masuk menu Akun\n2.	tap Simbol Bookmark di sebelah Simbol edit disebalah kanan sejajar dengan foto avatar.\n3.	Pilih bookmart yang akan dibaca.',
                              size: small,
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
                              text: 'Cara merubah bahasa aplikasi',
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
                              text:
                                  '1.	Masuk menu Seting\n2.	Pilih Bahasa\n3.	Pilih Bahasa Inggris',
                              size: small,
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
                              text: 'Pengaduan terhadap konten buku',
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
                              text:
                                  '1.	Tap icon tanda seru di pojok kanan atas\n2.	Isi judul bukunya dan pesan keluhannya\n3.	Tap tombol Kirim\n4.	Keluhan anda akan terkirim dan akan di proses oleh pihak puskurbuk',
                              size: small,
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
