import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:wall_dock/full_screen.dart';
import 'package:wall_dock/style/loading.dart';
import 'home.dart';
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
  final pageController = PageController(initialPage: 1);
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
  int per_page = 20;
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
        body: PageView(
          scrollDirection: Axis.horizontal,
          onPageChanged: (val) {
            print(val);
            if (val == 1) {
              setState(() {
                currentPosition = 0;
                response = null;
              });
            } else {
              setState(() {
                currentPosition = 1;
                response = null;
              });
            }
          },
          children: <Widget>[
            _buildPage("Latest", "latest",
                getPexelPopular(per_page, page_number, null)),
            _buildPage("Popular", "popular",
                getPexelLatest(per_page, page_number, null)),
          ],
        ));
  }

  _buildPage(String title, String order, Future future) {
    return FutureBuilder(
      future: future,
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
                  title,
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
                          Navigator.push(context,
                              new MaterialPageRoute(builder: (context) {
                            var fullScreenImage = new FullScreenImage(
                                imgPath: imageModel.hits[index].largeUrl,
                                user: imageModel.hits[index].user,
                                likes: imageModel.hits[index].likes,
                                id: imageModel.hits[index].id,
                                download: imageModel.hits[index].download,
                                view: imageModel.hits[index].view,
                                size: imageModel.hits[index].size,
                                iwidth: imageModel.hits[index].iwidth,
                                iheight: imageModel.hits[index].iheight,
                                comments: imageModel.hits[index].comments);
                            return fullScreenImage;
                          }));
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
                                  child: ExtendedImage.network(
                                    imageModel.hits[index].webUrl,
                                    fit: BoxFit.cover,
                                    cache: true,
                                    enableMemoryCache: true,
                                    filterQuality: FilterQuality.high,
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
                                          style: GoogleFonts.dancingScript(
                                              fontSize: 15,
                                              textStyle: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: colorTransparent,
            ),
          );
        }
      },
    );
  }
}
