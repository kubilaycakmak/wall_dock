import 'dart:convert';
import 'dart:math';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'full_screen.dart';
import 'model/api_call.dart';
import 'style/color.dart';

class PopularPage extends StatefulWidget {
  PopularPage({Key key}) : super(key: key);

  @override
  _PopularPageState createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  int page_number = 1;
  int per_page = 20;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    //FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          response = null;
          per_page += 20;
          if (per_page == 200) {
            page_number++;
          }
        });
      }
    });
    // _bannerAd = createBannerAd()
    //   ..load()
    //   ..show(anchorType: AnchorType.bottom, anchorOffset: 56.0);
  }

  @override
  void dispose() {
    // _bannerAd?.dispose();
    // _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorDark,
        body: FutureBuilder(
          future: getPexelsImages(per_page, page_number, 'popular', null),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text(
                'has error while response from server',
                style: TextStyle(color: Colors.white),
              );
            } else if (snapshot.hasData) {
              return StaggeredGridView.countBuilder(
                controller: _scrollController,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                staggeredTileBuilder: (index) =>
                    StaggeredTile.count(2, index.isEven ? 2 : 3),
                padding: EdgeInsets.all(8.0),
                crossAxisCount: 4,
                itemCount: imageModel.hits.length,
                itemBuilder: (context, index) {
                  return Material(
                      elevation: 8.0,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new FullScreenImage(
                                    imageModel.hits[index].largeUrl,
                                    imageModel.hits[index].user,
                                    imageModel.hits[index].likes,
                                    imageModel.hits[index].id,
                                    imageModel.hits[index].download,
                                    imageModel.hits[index].view,
                                    imageModel.hits[index].size,
                                    imageModel.hits[index].iwidth,
                                    imageModel.hits[index].iheight,
                                    imageModel.hits[index].comments))),
                        child: Hero(
                          tag: imageModel.hits[index].largeUrl,
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
                                        imageModel.hits[index].webUrl),
                                    fit: BoxFit.cover,
                                    placeholder: AssetImage("assets/wall.gif"),
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
                                          '@' + imageModel.hits[index].user,
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
