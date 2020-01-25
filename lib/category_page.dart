import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall_dock/detail_category.dart';
import 'package:wall_dock/style/color.dart';
import 'style/color.dart';
import 'style/text.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGray,
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
                    padding: EdgeInsets.only(top: 30, left: 15),
                    child: Text('Category', style: titleStyle,),
                  ),
                  SizedBox(height: 30,),
            _buildListItem("fashion", "assets/fashion.jpg"),
            _buildListItem("nature", "assets/nature.jpg"),
            _buildListItem("backgrounds", "assets/background.jpg"),
            _buildListItem("science", "assets/science.jpg"),
            _buildListItem("education", "assets/education.jpg"),
            _buildListItem("people", "assets/people.jpg"),
            _buildListItem("feelings", "assets/feel.jpg"),
            _buildListItem("religion", "assets/regions.jpg"),
            _buildListItem("health", "assets/health.jpg"),
            _buildListItem("places", "assets/places.jpg"),
            _buildListItem("animals", "assets/animal.jpg"),
            _buildListItem("industry", "assets/factory.jpg"),
            _buildListItem("food", "assets/food.jpg"),
            _buildListItem("computer", "assets/computer.jpg"),
            _buildListItem("sports", "assets/sports.jpg"),
            _buildListItem("transportation", "assets/transportation.jpg"),
            _buildListItem("travel", "assets/travel.jpg"),
            _buildListItem("buildings", "assets/buildings.jpg"),
            _buildListItem("business", "assets/business.jpg"),
            _buildListItem("music", "assets/music.jpg"),
          ],
        ),
      ),
    );
  }

  _buildListItem(String type, String path) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0.3),
      child: InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailPage(
                      dataCategory: type,
                    )));
            },
            child: Stack(
              children: <Widget>[
                Container(
              height: 150.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(path),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black26, BlendMode.darken))),
            ),
          Container(
            height: 150.0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    type,
                    style: GoogleFonts.montserrat(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        textStyle: TextStyle(color: Colors.white54)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
              ],
            )

          ),
            )])));
  }
}
