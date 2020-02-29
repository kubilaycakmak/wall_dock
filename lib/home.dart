import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wall_dock/entry_screen.dart';
import 'package:wall_dock/favorite_page.dart';
import 'category_page.dart';
import 'style/color.dart';

var currentPosition = 0;

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectedItem = 0;
  final _totalDots = 5;

  final controller = PageController(viewportFraction: 0.8);
  List children = [EntryScreen(), CategoryPage(), FavoritePage()];

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
            activeIcon: Icon(LineIcons.home),
            backgroundColor: colorGray,
            icon: Icon(Icons.home),
            title: Text(
              'Latest'
            )),
          BottomNavigationBarItem(
            activeIcon: Icon(LineIcons.th_list),
            backgroundColor: colorGray,
            icon: Icon(Icons.view_list),
            title: Text(
              'Categories'
            )),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.favorite_border),
            backgroundColor: colorGray,
            icon: Icon(Icons.favorite),
            title: Text(
              'Favorite'
            )),
        ],
      ),
    );
  }
}
