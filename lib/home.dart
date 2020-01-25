import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wall_dock/category_page.dart';
import 'package:wall_dock/favorite_page.dart';
import 'package:wall_dock/style/text.dart';
import 'home_page.dart';
import 'popular_page.dart';
import 'style/color.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectedItem = 0;
  List children = [HomePage(), CategoryPage(), PopularPage(), FavoritePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGray,
      body: Stack(children: [
        Container(
          height: 20,
        ),
        children[selectedItem]
      ]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorGray,
        selectedItemColor: colorDark,
        iconSize: 28,
        currentIndex: selectedItem,
        elevation: 0,
        unselectedLabelStyle: TextStyle(color: colorWhite),
        unselectedItemColor: colorDark,
        onTap: (currentIndex) {
          setState(() {
            selectedItem = currentIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
              backgroundColor: colorGray,
              icon: selectedItem == 0 ? Icon(Icons.home) : Icon(LineIcons.home),
              title: Container(
                height: 5.0,
                width: 5.0,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: colorDark),
              )),
          BottomNavigationBarItem(
              backgroundColor: colorGray,
              icon: selectedItem == 1
                  ? Icon(LineIcons.th_list)
                  : Icon(Icons.list),
              title: Container(
                height: 5.0,
                width: 5.0,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: colorDark),
              )),
          BottomNavigationBarItem(
              backgroundColor: colorGray,
              icon: selectedItem == 2
                  ? Icon(Icons.star)
                  : Icon(LineIcons.star_half_o),
              title: Container(
                height: 5.0,
                width: 5.0,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: colorDark),
              )),
          BottomNavigationBarItem(
              backgroundColor: colorGray,
              icon: selectedItem == 3
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              title: Container(
                height: 5.0,
                width: 5.0,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: colorDark),
              )),
        ],
      ),
    );
  }
}
