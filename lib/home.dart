import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall_dock/category_page.dart';
import 'package:wall_dock/favorite_page.dart';
import 'package:wall_dock/random_page.dart';
import 'package:wall_dock/style/text.dart';
import 'home_page.dart';
import 'style/color.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var selectedItem = 0;
    List children = [
      HomePage(),
      CategoryPage(),
      RandomPage(),
      FavoritePage()
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorDark,
        title: selectedItem == 0 ? Text("Lastest",style: GoogleFonts.montserrat(textStyle: titleStyle),) 
        : selectedItem == 1 ? Text("Categories",style: GoogleFonts.montserrat(textStyle: titleStyle),) 
        : selectedItem == 2 ? Text('Randomly',style: GoogleFonts.montserrat(textStyle: titleStyle),) 
        : selectedItem == 3 ? Text('My Favorites',style: GoogleFonts.montserrat(textStyle: titleStyle),) 
        : Text(''),
        //title: Text('Wall Dock', style: GoogleFonts.montserrat(textStyle: titleStyle),),
        centerTitle: true,
      ),
      backgroundColor: colorDarkLighter,
      body: children[selectedItem],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorDark,
        selectedItemColor: colorYellowish,
        iconSize: 30,
        currentIndex: selectedItem,
        unselectedLabelStyle: TextStyle(color: colorDark),
        unselectedItemColor: colorTransparent,
        onTap: (currentIndex){
          setState(() {
            selectedItem = currentIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: colorDark,
            icon: Icon(Icons.home),
            title: Container(
              height: 5.0,
              width: 5.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorYellowish
              ),
            )
          ),
          BottomNavigationBarItem(
            backgroundColor: colorDark,
            icon: Icon(Icons.category),
            title: Container(
              height: 5.0,
              width: 5.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorYellowish
              ),
            )
          ),
          BottomNavigationBarItem(
            backgroundColor: colorDark,
            icon: Icon(Icons.text_rotation_down),
            title: Container(
              height: 5.0,
              width: 5.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorYellowish
              ),
            )
          ),   
          BottomNavigationBarItem(
            backgroundColor: colorDark,
            icon: Icon(Icons.favorite),
            title: Container(
              height: 5.0,
              width: 5.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorYellowish
              ),
            )
          ), 
        ],
      ),
    );
  }
}