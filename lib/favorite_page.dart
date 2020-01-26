import 'package:flutter/material.dart';

import 'style/text.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 66, left: 5),
            child: Text('Favorite', style: titleStyle,),
          ),
        ],
      ),
    );
  }
}