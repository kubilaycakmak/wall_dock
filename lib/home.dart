import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wall_dock/category_page.dart';
import 'package:wall_dock/favorite_page.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'home_page.dart';
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
  List children = [HomePage(), CategoryPage(), FavoritePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGray,
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 180),
          child: DotsIndicator(
            dotsCount: 2,
            reversed: false,
            position: currentPosition.toDouble(),
            axis: Axis.horizontal,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        ),
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
              )),
          BottomNavigationBarItem(
              backgroundColor: colorGray,
              icon: selectedItem == 1
                  ? Icon(LineIcons.th_list)
                  : Icon(Icons.list),
              title: Container(
                height: 5.0,
                width: 5.0,
              )),
          BottomNavigationBarItem(
              backgroundColor: colorGray,
              icon: selectedItem == 2
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              title: Container(
                height: 5.0,
                width: 5.0,
              )),
        ],
      ),
    );
  }
}
