import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall_dock/style/color.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorDark,
      body: Container(
        child: ListView(
          children: <Widget>[
            _buildListItem("fashion","assets/fashion.jpg"),
            _buildListItem("nature","assets/nature.jpg"),
            _buildListItem("backgrounds","assets/background.jpg"),
            _buildListItem("science","assets/science.jpg"),
            _buildListItem("education","assets/education.jpg"),
            _buildListItem("people","assets/people.jpg"),
            _buildListItem("feelings","assets/feelings.jpg"),
            _buildListItem("religion","assets/religion.jpg"),
            _buildListItem("health","assets/health.jpg"),
            _buildListItem("places","assets/places.jpg"),
            _buildListItem("animals","assets/animal.jpg"),
            _buildListItem("industry","assets/industry.jpg"),
            _buildListItem("food","assets/food.jpg"),
            _buildListItem("computer","assets/computer.jpg"),
            _buildListItem("sports","assets/sports.jpg"),
            _buildListItem("transportation","assets/transportation.jpg"),
            _buildListItem("travel","assets/travel.jpg"),
            _buildListItem("buildings","assets/buildings.jpg"),
            _buildListItem("business","assets/business.jpg"),
            _buildListItem("music","assets/music.jpg"),
            // _buildListItem("nature"),
            // _buildListItem("backgrounds"),
            // _buildListItem("science"),
            // _buildListItem("education"),
            // _buildListItem("people"),
            // _buildListItem("feelings"),
            // _buildListItem("religion"),
            // _buildListItem("health"),
            // _buildListItem("places"),
            // _buildListItem("animals"),
            // _buildListItem("industry"),
            // _buildListItem("food"),
            // _buildListItem("computer"),
            // _buildListItem("sports"),
            // _buildListItem("transportation"),
            // _buildListItem("travel"),
            // _buildListItem("buildings"),
            // _buildListItem("business"),
            // _buildListItem("music"),
          ],
        ),
      ),
    );
  }
  _buildListItem(String type, String path){
    String imageUrl = "https://pixabay.com/api/?key=14951209-61b2f6019e4d1a85e007275aa&category=$type";
    var response;
    Future<Map> getPexelsImages() async {
      if(response==null){
        response = await http.get(Uri.encodeFull(imageUrl));
      }
      if(response.statusCode == 200){
        return json.decode(response.body);
      }
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Stack(
        children: <Widget>[
          // FutureBuilder(
          //   future: getPexelsImages(),
          //   builder: (context, snapshot){
          //     Map data = snapshot.data;
          //     if(snapshot.hasError){
          //       print(snapshot.error);
          //       return Text('has error while response from server',
          //         style: TextStyle(color: Colors.white),
          //       );
          //     }else if(snapshot.hasData){
          //       return 
          //     }else if(!snapshot.hasData){
          //       return Center(child: CircularProgressIndicator(),);
          //     }
          //   },
          // ),
          
          Container(
            height: 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(path),
                // NetworkImage("${data['hits'][3]['webformatURL']}"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken)
              )
            ),
          ),
          Container(
            height: 150.0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(type,
                    style: GoogleFonts.montserrat(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      textStyle: TextStyle(color: Colors.white54)
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: (){
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => DetailsPage(imgPath: imgPath, title: city, bannerTitle: bannerTitle,)
                      // ));
                    },
                    child: Container(
                      height: 50.0,
                      width: 125.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white54
                      ),
                      child: Center(
                        child: Text('Explore now',
                          style: GoogleFonts.montserrat(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            textStyle: TextStyle(color: Colors.black87)
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
