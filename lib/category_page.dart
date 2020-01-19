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
            _buildListItem("fashion"),
            _buildListItem("nature"),
            _buildListItem("backgrounds"),
            _buildListItem("science"),
            _buildListItem("education"),
            _buildListItem("people"),
            _buildListItem("feelings"),
            _buildListItem("religion"),
            _buildListItem("health"),
            _buildListItem("places"),
            _buildListItem("animals"),
            _buildListItem("industry"),
            _buildListItem("food"),
            _buildListItem("computer"),
            _buildListItem("sports"),
            _buildListItem("transportation"),
            _buildListItem("travel"),
            _buildListItem("buildings"),
            _buildListItem("business"),
            _buildListItem("music"),
          ],
        ),
      ),
    );
  }
  _buildListItem(String type){
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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
          ),
          FutureBuilder(
            future: getPexelsImages(),
            builder: (context, snapshot){
              Map data = snapshot.data;
              if(snapshot.hasError){
                print(snapshot.error);
                return Text('has error while response from server',
                  style: TextStyle(color: Colors.white),
                );
              }else if(snapshot.hasData){
                return Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage("${data['hits'][1]['webformatURL']}"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black87, BlendMode.dstATop)
                    )
                  ),
                );
              }else if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }
            },
          ),
          Container(
            height: 200.0,
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
