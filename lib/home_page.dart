import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:wall_dock/full_screen.dart';
import 'package:wall_dock/model/image_model.dart';
import 'model/api_call.dart';
import 'style/color.dart';

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
  int per_page = 20;
  var response;
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
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          response = null;
          per_page += 20;
          if(per_page == 200){
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
        backgroundColor: colorDark,
        body: FutureBuilder(
          future: getPexelsImages(per_page, page_number, response, 'latest'),
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
                                      imageModel.hits[index].largeUrl)));
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
                                          '@' +
                                              imageModel.hits[index].user,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              textStyle: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      gradient: LinearGradient(
                                          begin: FractionalOffset.bottomCenter,
                                          end: FractionalOffset.topCenter,
                                          colors: [
                                            Colors.grey.withOpacity(0.0),
                                            Colors.black87,
                                          ],
                                          stops: [
                                            0.0,
                                            1.0
                                          ])),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Text(
                                          '♥ ' +
                                              imageModel.hits[index].likes.toString(),
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              textStyle: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        IconButton(
                                          alignment: Alignment.topCenter,
                                          color: Colors.red,
                                          icon: Icon(favIconBorder, size: 30,),
                                          onPressed: (){
                                            setState(() {
                                              favIconBorder=favIconFill;
                                            });
                                          }),
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
