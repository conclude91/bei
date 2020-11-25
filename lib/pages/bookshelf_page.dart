import 'package:bei/pages/detail_book_page.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/card_book_list.dart';
import 'package:bei/widgets/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookShelfPage extends StatefulWidget {
  @override
  _BookShelfPageState createState() => _BookShelfPageState();
}

class _BookShelfPageState extends State<BookShelfPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, _) => Scaffold(
        body: Container(
          color: AppColor.backgroundColor,
          height: double.infinity,
          padding: EdgeInsets.only(
            top: AppDimen.paddingNormal,
          ),
          child: Column(
            children: [
              Container(
                height: AppDimen.appBarHeight,
                color: AppColor.backgroundColor,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: PrimaryText(
                        text: bookProvider.isSwitch ? 'Rak Buku' : 'Bookshelf',
                        size: AppDimen.regular,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: AppColor.primaryColor,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: bookProvider.getAll().length,
                  itemBuilder: (BuildContext context, int index) {
                    return (bookProvider.getAll()[index].id == 364 ||
                            bookProvider.getAll()[index].id == 336 ||
                            bookProvider.getAll()[index].id == 331)
                        ? GestureDetector(
                            child: CardBookList(
                              book: bookProvider.getAll()[index],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailBookPage(
                                    book: bookProvider.getAll()[index],
                                  ),
                                ),
                              );
                            },
                          )
                        : SizedBox();
                  },
                ),
              ),
              // Expanded(
              //   child: FutureBuilder(
              //     future: showDirectory(),
              //     builder: (context, AsyncSnapshot snapshot) {
              //       if (!snapshot.hasData) {
              //         return Center(child: CircularProgressIndicator());
              //       } else {
              //         Container(
              //           child: ListView.builder(
              //             itemCount: snapshot.data.length,
              //             scrollDirection: Axis.horizontal,
              //             itemBuilder: (BuildContext context, int index) {
              //               return Text('${snapshot.data[index].title}');
              //             },
              //           ),
              //         );
              //       }
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // showDirectory() async {
  //   return await getExternalStorageDirectory();
  // }
}
