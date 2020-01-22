import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wall_dock/style/text.dart';
import 'full_screen.dart';
import 'style/color.dart';

class DetailPage extends StatefulWidget {
  final String dataCategory;
  DetailPage({this.dataCategory});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var response;

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        "https://pixabay.com/api/?key=14951209-61b2f6019e4d1a85e007275aa&category=${widget.dataCategory}";
    Future<Map> getCategoriedImages() async {
      if (response == null) {
        response = await http.get(Uri.encodeFull(imageUrl));
      }
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    }

    print(widget.dataCategory);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget.dataCategory}',
            style: titleStyle,
          ),
          centerTitle: true,
          backgroundColor: colorDark,
        ),
        backgroundColor: colorDark,
        body: FutureBuilder(
          future: getCategoriedImages(),
          builder: (context, snapshot) {
            Map data = snapshot.data;
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text(
                'has error while response from server',
                style: TextStyle(color: Colors.white),
              );
            } else if (snapshot.hasData) {
              return StaggeredGridView.countBuilder(
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                staggeredTileBuilder: (index) =>
                    StaggeredTile.count(2, index.isEven ? 2 : 3),
                padding: EdgeInsets.all(8.0),
                crossAxisCount: 4,
                itemCount: 19,
                itemBuilder: (context, index) {
                  return Material(
                      elevation: 8.0,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new FullScreenImage(
                                    "${data['hits'][index]['largeImageURL']}"))),
                        child: Hero(
                          tag: "${data['hits'][index]['largeImageURL']}",
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 300.0,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  child: FadeInImage(
                                    image: NetworkImage(
                                        "${data['hits'][index]['largeImageURL']}"),
                                    fit: BoxFit.cover,
                                    placeholder:
                                        AssetImage("assets/wallLogo.png"),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      gradient: LinearGradient(
                                          begin: FractionalOffset.topCenter,
                                          end: FractionalOffset.bottomCenter,
                                          colors: [
                                            Colors.grey.withOpacity(0.0),
                                            Colors.black54,
                                          ],
                                          stops: [
                                            0.0,
                                            1.0
                                          ])),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '@' +
                                              '${data['hits'][index]['user']}',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              textStyle: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                },
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
