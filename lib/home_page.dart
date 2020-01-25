import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:wall_dock/full_screen.dart';
import 'package:wall_dock/style/loading.dart';
import 'model/api_call.dart';
import 'style/color.dart';
import 'style/text.dart';

const String testDevice = '';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
    testDevices: <String>[],
    //testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['wallpapers', 'walls', 'amoled'],
    childDirected: true,
  );
  int _counter = 0;
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  ScrollController _scrollController = new ScrollController();
  ScrollController _scrollControllerGrid = new ScrollController();
  int per_page = 40;
  int page_number = 1;

  BannerAd createBannerAd() {
    return new BannerAd(
        adUnitId: "ca-app-pub-9287966150990663/2963995877",
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("Banner event :  + $event");
        });
  }

  InterstitialAd createInterStitialAd() {
    return new InterstitialAd(
        adUnitId:
            //InterstitialAd.testAdUnitId,
            "ca-app-pub-9287966150990663/9828787128",
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("Interstitial event :  + $event");
        });
  }

  @override
  void initState() {
    super.initState();
    response = null;
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels.toInt() ==
              _scrollController.position.maxScrollExtent.toInt() - 1000 ||
          _scrollController.position.pixels.toInt() ==
              _scrollController.position.maxScrollExtent.toInt()) {
        setState(() {
          showBottomDialog(context);
          t = new Timer(Duration(milliseconds: 500), () {
            Navigator.pop(context, false);
            t.cancel();
          });
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
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorGrayTransparent,
        body: FutureBuilder(
          future: getPexelsLatestImages(per_page, page_number, null),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text(
                'has error while response from server',
                style: TextStyle(color: Colors.white),
              );
            } else if (snapshot.hasData) {
              return ListView(
                shrinkWrap: false,
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 15),
                    child: Text(
                      'Latest',
                      style: titleStyle,
                    ),
                  ),
                  StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    controller: _scrollControllerGrid,
                    mainAxisSpacing: 0.5,
                    crossAxisSpacing: 0.5,
                    staggeredTileBuilder: (index) =>
                        StaggeredTile.count(2, index.isEven ? 2 : 3),
                    padding: EdgeInsets.only(top: 30, left: 0, right: 0),
                    crossAxisCount: 4,
                    itemCount: imageModel.hits.length,
                    itemBuilder: (context, index) {
                      return Material(
                          elevation: 5,
                          shadowColor: colorDark,
                          type: MaterialType.transparency,
                          color: colorGrayTransparent,
                          child: InkWell(
                            onTap: () {
                              // _counter++;
                              // print(_counter);
                              // if (_counter % 1 == 0) {
                              //   createInterStitialAd()
                              //     ..load()
                              //     ..show();
                              // }
                              Navigator.push(
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
                                          imageModel.hits[index].comments)));
                            },
                            child: Hero(
                              tag: imageModel.hits[index].largeUrl,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 300.0,
                                      width: 300.0,
                                      child: Image(
                                        image: NetworkImage(
                                            imageModel.hits[index].webUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              '@' + imageModel.hits[index].user,
                                              style: GoogleFonts.dancingScript(
                                                  fontSize: 15,
                                                  textStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.white,
                                    //       gradient: LinearGradient(
                                    //           begin: FractionalOffset.bottomCenter,
                                    //           end: FractionalOffset.topCenter,
                                    //           colors: [
                                    //             Colors.grey.withOpacity(0.0),
                                    //             Colors.black87,
                                    //           ],
                                    //           stops: [
                                    //             0.8,
                                    //             1.0
                                    //           ])),
                                    //   child: Center(
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceBetween,
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.stretch,
                                    //       children: <Widget>[
                                    //         Text(
                                    //           '♥ ' +
                                    //               imageModel.hits[index].likes
                                    //                   .toString(),
                                    //           style: GoogleFonts.montserrat(
                                    //               fontSize: 15,
                                    //               textStyle: TextStyle(
                                    //                   color: Colors.white)),
                                    //         ),
                                    //         IconButton(
                                    //             alignment: Alignment.topCenter,
                                    //             color: Colors.red,
                                    //             icon: Icon(
                                    //               favIconBorder,
                                    //               size: 30,
                                    //             ),
                                    //             onPressed: () {
                                    //               setState(() {
                                    //                 favIconBorder = favIconFill;
                                    //               });
                                    //             }),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                  )
                ],
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: colorTransparent,
                ),
              );
            }
          },
        ));
  }
}
