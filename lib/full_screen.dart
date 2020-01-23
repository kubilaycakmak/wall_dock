import 'package:flutter/material.dart';
import 'package:wall_dock/style/color.dart';

class FullScreenImage extends StatelessWidget {
  String imgPath;
  FullScreenImage(this.imgPath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorDark,
      body: new SizedBox.expand(
        child: Container(
          child: Stack(
            children: <Widget>[
              new Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: imgPath,
                  child: new Image.network(imgPath),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
