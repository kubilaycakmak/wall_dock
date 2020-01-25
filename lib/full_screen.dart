import 'package:flutter/material.dart';
import 'package:wall_dock/model/api_call.dart';
import 'package:wall_dock/style/color.dart';
import 'package:wall_dock/style/text.dart';

class FullScreenImage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String imgPath;
  final int likes, id, download, view, size, iwidth, iheight, comments;
  final String user;
  FullScreenImage(this.imgPath, this.user, this.likes, this.id, this.download,
      this.view, this.size, this.iwidth, this.iheight, this.comments);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: _buildFloatActionSheet(
        user: user,
        likes: likes,
        id: id,
        download: download,
        view: view,
        size: size,
        imageWidth: iwidth,
        imageHeight: iheight,
        comments: comments,
      ),
      backgroundColor: colorDark,
      body: new SizedBox.expand(
        child: Container(
          color: colorTransparent,
          child: Stack(
            children: <Widget>[
              new Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: imgPath,
                  child: new Image.network(
                    imgPath,
                  ),
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
                      leading: null,
                      actions: <Widget>[],
                    ),
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

class _buildFloatActionSheet extends StatefulWidget {
  final int likes, id, download, view, size, imageWidth, imageHeight, comments;
  final String user;
  _buildFloatActionSheet(
      {Key key,
      this.user,
      this.likes,
      this.id,
      this.download,
      this.view,
      this.size,
      this.imageWidth,
      this.imageHeight,
      this.comments})
      : super(key: key);

  @override
  __buildFloatActionSheetState createState() => __buildFloatActionSheetState();
}

class __buildFloatActionSheetState extends State<_buildFloatActionSheet> {
  bool showFab = true;
  @override
  Widget build(BuildContext context) {
    return showFab
        ? FloatingActionButton(
            child: Icon(
              Icons.arrow_downward,
              color: colorDark,
            ),
            backgroundColor: colorYellowish,
            onPressed: () {
              var bottomSheetController = showBottomSheet(
                  elevation: 10,
                  context: context,
                  builder: (context) => Container(
                        color: Colors.grey[900],
                        height: 220,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: colorGray,
                                    borderRadius: BorderRadius.circular(20)),
                                width: double.maxFinite,
                                height: 3,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    size: 40,
                                    color: colorOfIconButtons,
                                  ),
                                  onPressed: null,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.wallpaper,
                                    size: 40,
                                    color: colorOfIconButtons,
                                  ),
                                  onPressed: null,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.save,
                                    size: 40,
                                    color: colorOfIconButtons,
                                  ),
                                  onPressed: null,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.favorite_border,
                                    size: 40,
                                    color: colorOfIconButtons,
                                  ),
                                  onPressed: null,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GridView(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 3,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 1),
                              children: <Widget>[
                                Card(
                                  elevation: 3,
                                  child: Center(
                                    child: Text(
                                      widget.download.toString() + " Downloads",
                                      style: paragStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  color: colorTransparent,
                                ),
                                Card(
                                  elevation: 3,
                                  child: Center(
                                      child: Text(
                                    widget.view.toString() + " Views",
                                    style: paragStyle,
                                    textAlign: TextAlign.center,
                                  )),
                                  color: colorTransparent,
                                ),
                                Card(
                                  elevation: 3,
                                  child: Center(
                                      child: Text(
                                    widget.likes.toString() + " Likes",
                                    style: paragStyle,
                                    textAlign: TextAlign.center,
                                  )),
                                  color: colorTransparent,
                                ),
                                Card(
                                  elevation: 3,
                                  child: Center(
                                      child: Text(
                                    "by " + widget.user,
                                    style: paragStyle,
                                    textAlign: TextAlign.center,
                                  )),
                                  color: colorTransparent,
                                ),
                                Card(
                                  elevation: 3,
                                  child: Center(
                                      child: Text(
                                    widget.imageWidth.toString() +
                                        ' x ' +
                                        widget.imageHeight.toString(),
                                    style: paragStyle,
                                    textAlign: TextAlign.center,
                                  )),
                                  color: colorTransparent,
                                ),
                                Card(
                                  elevation: 3,
                                  child: Center(
                                      child: Text(
                                    (widget.size / 1000000).toString()[0] +
                                        (widget.size / 1000000).toString()[1] +
                                        (widget.size / 1000000).toString()[2] +
                                        ' MB',
                                    style: paragStyle,
                                    textAlign: TextAlign.center,
                                  )),
                                  color: colorTransparent,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
              showFoatingActionButton(false);
              bottomSheetController.closed.then((value) {
                showFoatingActionButton(true);
              });
            },
          )
        : Container();
  }

  void showFoatingActionButton(bool value) {
    setState(() {
      showFab = value;
    });
  }
}
