import 'package:bei/pages/search_book_page.dart';
import 'package:bei/provider/book_provider.dart';
import 'package:bei/themes/app_color.dart';
import 'package:bei/values/app_dimen.dart';
import 'package:bei/widgets/card_book_list.dart';
import 'package:bei/widgets/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListBookPage extends StatefulWidget {
  final String level;

  ListBookPage({this.level});

  @override
  _ListBookPageState createState() => _ListBookPageState();
}

class _ListBookPageState extends State<ListBookPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, _) => Scaffold(
        body: Container(
          color: AppColor.backgroundColor,
          padding: EdgeInsets.only(
            top: AppDimen.paddingNormal,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: AppDimen.appBarHeight,
                width: double.infinity,
                color: AppColor.backgroundColor,
                padding: EdgeInsets.only(
                  left: AppDimen.paddingSmall,
                  right: AppDimen.paddingSmall,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: AppDimen.tiny,
                          ),
                          child: Icon(Icons.arrow_back_ios),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: PrimaryText(
                        text: widget.level,
                        size: AppDimen.regular,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: AppDimen.paddingTiny,
                          ),
                          child: Icon(Icons.search),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchPage(),
                            ),
                          );
                        },
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
                child: ListView.separated(
                  padding: EdgeInsets.only(
                    top: 0,
                  ),
                  shrinkWrap: true,
                  itemCount: bookProvider.getAllByLevel(widget.level).length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardBookList(
                      book: bookProvider.getAllByLevel(widget.level)[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(
                        left: AppDimen.paddingNormal,
                        right: AppDimen.paddingNormal,
                      ),
                      child: Divider(
                        color: AppColor.primaryColor,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class DataSearch extends SearchDelegate<String> {
//   List<String> originList = [
//     "Snake",
//     "Elephant",
//     "Cats",
//     "Dog",
//     "Orion",
//     "Boomerang",
//     "Pelican",
//     "Ghost",
//     "Eagle",
//     "Horse Head",
//     "Elephant Trunk",
//     "Butterfly",
//     "Komodo",
//     "Tiger",
//     "Lion",
//   ];
//   List<String> filteredList = [
//     "Snake",
//     "Elephant",
//     "Cats",
//   ];
//   String keyword;

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [IconButton(icon: Icon(Icons.clear), onPressed: () {})];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return GestureDetector(
//       child: Icon(
//         Icons.arrow_back_ios,
//       ),
//       onTap: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {}

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestionList = query.isEmpty ? filteredList : originList;
//     return ListView.builder(
//       itemBuilder: (context, index) => ListTile(
//         leading: Icon(Icons.location_city),
//         title: Text(suggestionList[index]),
//         onTap: () {
//           print(suggestionList[index]);
//         },
//       ),
//       itemCount: suggestionList.length,
//     );
//   }
// }
