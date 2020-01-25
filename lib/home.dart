import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      // appBar: AppBar(
      //   backgroundColor: colorWhite,
      //   title: selectedItem == 0
      //       ? Text(
      //           "Latest",
      //           style: GoogleFonts.montserrat(textStyle: titleStyle),
      //         )
      //       : selectedItem == 1
      //           ? Text(
      //               "Categories",
      //               style: GoogleFonts.montserrat(textStyle: titleStyle),
      //             )
      //           : selectedItem == 2
      //               ? Text(
      //                   'Popular',
      //                   style: GoogleFonts.montserrat(textStyle: titleStyle),
      //                 )
      //               : selectedItem == 3
      //                   ? Text(
      //                       'My Favorites',
      //                       style:
      //                           GoogleFonts.montserrat(textStyle: titleStyle),
      //                     )
      //                   : Text(''),
      //   //title: Text('Wall Dock', style: GoogleFonts.montserrat(textStyle: titleStyle),),
      //   centerTitle: true,
      // ),
      backgroundColor: colorGray,
      body: Stack(children: [
        Container(
          height: 20,
        ),
        children[selectedItem]
      ]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorGray,
        selectedItemColor: colorWhite,
        iconSize: 20,
        currentIndex: selectedItem,
        elevation: 0,
        unselectedLabelStyle: TextStyle(color: colorWhite),
        unselectedItemColor: colorTransparent,
        onTap: (currentIndex) {
          setState(() {
            selectedItem = currentIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
              backgroundColor: colorGrayTransparent,
              icon: Icon(Icons.home),
              title: Container(
                height: 2.0,
                width: 5.0,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: colorWhite),
              )),
          BottomNavigationBarItem(
              backgroundColor: colorGrayTransparent,
              icon: Icon(Icons.category),
              title: Container(
                height: 2.0,
                width: 5.0,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: colorWhite),
              )),
          BottomNavigationBarItem(
              backgroundColor: colorGrayTransparent,
              icon: Icon(Icons.text_rotation_down),
              title: Container(
                height: 5.0,
                width: 5.0,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: colorWhite),
              )),
          BottomNavigationBarItem(
              backgroundColor: colorGrayTransparent,
              icon: Icon(Icons.favorite),
              title: Container(
                height: 5.0,
                width: 5.0,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: colorWhite),
              )),
        ],
      ),
    );
  }
}
