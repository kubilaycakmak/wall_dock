import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  ScrollController _scrollControllerGrid = new ScrollController();

  @override
  void initState() {
    super.initState();
    response = null;
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
    return Scaffold(backgroundColor: colorGrayTransparent, body: Container());
  }
}
