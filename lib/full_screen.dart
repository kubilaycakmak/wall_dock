import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:line_icons/line_icons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wall_dock/style/color.dart';
import 'package:wall_dock/style/text.dart';
import 'style/color.dart';
import 'style/custom_slider.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage(
      {this.imgPath,
      this.lowPixelImgPath,
      this.likes,
      this.id,
      this.download,
      this.view,
      this.size,
      this.iwidth,
      this.iheight,
      this.comments,
      this.user});

  String imgPath, lowPixelImgPath;
  final int likes, id, download, view, size, iwidth, iheight, comments;
  final String user;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool showFab = true;
  PhotoViewScaleStateController scaleStateController;
  double _value = 0;
  Future<File> _imageFile;
  static const platform = const MethodChannel('wallpaper');
  var filePath;
  Future<void> _getWallpaper() async {
    try {
      final int result =
          await platform.invokeMethod('getWallpaper', {"text": filePath});
    } on PlatformException catch (e) {
      Navigator.pop(context);
    }
  }

  void _onImageSetWallpaper(String url) async {
    var response = await http.get(url);
    filePath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
    _getWallpaper();
  }

  void _onImageSaveButtonPressed(String path) async {
    print("_onImageSaveButtonPressed");
    var response = await http.get('$path');

    debugPrint(response.statusCode.toString());

    var filePath = await ImagePickerSaver.saveFile(
        fileData: response.bodyBytes,
        title: 'ImagePickerPicture',
        description: 'example of image picker saver');

    var savedFile = File.fromUri(Uri.file(filePath));
    setState(() {
      _imageFile = Future<File>.sync(() => savedFile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: colorTransparent,
        //   leading: Container(),
        //   elevation: 0,
        // ),
        floatingActionButton: Align(
          alignment: Alignment.topRight,
          heightFactor: 11.5,
          child: _buildFloatActionSheet(
            user: widget.user,
            likes: widget.likes,
            id: widget.id,
            download: widget.download,
            view: widget.view,
            size: widget.size,
            imageWidth: widget.iwidth,
            imageHeight: widget.iheight,
            comments: widget.comments,
          ),
        ),
        key: widget.scaffoldKey,
        backgroundColor: colorDark,
        body: Stack(
          children: <Widget>[
            PhotoView(
              // loadingChild: Container(
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //     image: NetworkImage(widget.lowPixelImgPath),
              //     fit: BoxFit.cover,
              //   )),
              //   child: BackdropFilter(
              //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              //   ),
              // ),

              backgroundDecoration: BoxDecoration(
                  color: colorDark, backgroundBlendMode: BlendMode.darken),
              imageProvider: NetworkImage(widget.imgPath),
              filterQuality: FilterQuality.high,
              basePosition: Alignment.center,
              initialScale: PhotoViewComputedScale.contained * 1.4,
              maxScale: PhotoViewComputedScale.contained * 2,
              minScale: PhotoViewComputedScale.contained * 1,
              tightMode: false,
            ),
            Container(
              width: 300,
              height: 300,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: _value, sigmaY: _value),
                child: Container(
                  color: Colors.black.withOpacity(0.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 150,
                  color: colorDarkTransparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Card(
                            elevation: 1,
                            color: colorTransparent,
                            shape: CircleBorder(),
                            child: IconButton(
                              icon: Icon(
                                LineIcons.download,
                                size: 30,
                                color: colorOfIconButtons,
                              ),
                              onPressed: () {
                                _onImageSaveButtonPressed(widget.imgPath);
                              },
                            ),
                          ),
                          Card(
                            elevation: 1,
                            color: colorTransparent,
                            shape: CircleBorder(),
                            child: IconButton(
                              icon: Icon(
                                LineIcons.picture_o,
                                size: 30,
                                color: colorOfIconButtons,
                              ),
                              onPressed: null,
                            ),
                          ),
                          Card(
                            elevation: 1,
                            color: colorTransparent,
                            shape: CircleBorder(),
                            child: IconButton(
                              icon: Icon(
                                LineIcons.close,
                                size: 30,
                                color: colorOfIconButtons,
                              ),
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     new MaterialPageRoute(
                                //         builder: (BuildContext context) =>
                                //             HomePage()));
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.blur_on,
                            color: colorWhite,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: colorGray,
                              inactiveTrackColor: colorDarkLighter,
                              trackHeight: 10.0,
                              thumbColor: colorDarkLighter,
                              thumbShape: CustomSliderThumbCircle(
                                  thumbRadius: 20, max: 10, min: 0),
                              overlayColor: colorYellowish,
                              overlayShape: RoundSliderThumbShape(
                                  disabledThumbRadius: 10,
                                  enabledThumbRadius: 10),
                            ),
                            child: Slider(
                                max: 5,
                                value: _value,
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                    print(_value.toInt());
                                  });
                                }),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ));
  }

  void showFoatingActionButton(bool value) {
    setState(() {
      showFab = value;
    });
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
        ? Container(
            height: MediaQuery.of(context).size.height / 12.5,
            child: FloatingActionButton(
              child: Icon(
                LineIcons.info,
                color: colorGray,
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              onPressed: () {
                var bottomSheetController = showBottomSheet(
                    elevation: 0,
                    context: context,
                    builder: (context) {
                      return Container(
                        decoration: BoxDecoration(
                          color: colorDarkTransparent,
                          backgroundBlendMode: BlendMode.darken,
                          // image: DecorationImage(
                          //     colorFilter: ColorFilter.mode(
                          //         Colors.black38, BlendMode.modulate),
                          //     // image: AssetImage('assets/wallpaper.jpg'),
                          //     fit: BoxFit.cover)),
                        ),
                        height: 150,
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
                            ClipRect(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                                child: GridView(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 3,
                                          crossAxisSpacing: 1,
                                          mainAxisSpacing: 1),
                                  children: <Widget>[
                                    Card(
                                      child: Center(
                                        child: Text(
                                          widget.download.toString() +
                                              " Downloads",
                                          style: detailStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      color: colorTransparent,
                                    ),
                                    Card(
                                      child: Center(
                                          child: Text(
                                        widget.view.toString() + " Views",
                                        style: detailStyle,
                                        textAlign: TextAlign.center,
                                      )),
                                      color: colorTransparent,
                                    ),
                                    Card(
                                      child: Center(
                                          child: Text(
                                        widget.likes.toString() + " Likes",
                                        style: detailStyle,
                                        textAlign: TextAlign.center,
                                      )),
                                      color: colorTransparent,
                                    ),
                                    Card(
                                      child: Center(
                                          child: Text(
                                        "by " + widget.user,
                                        style: detailStyle,
                                        textAlign: TextAlign.center,
                                      )),
                                      color: colorTransparent,
                                    ),
                                    Card(
                                      child: Center(
                                          child: Text(
                                        widget.imageWidth.toString() +
                                            ' x ' +
                                            widget.imageHeight.toString(),
                                        style: detailStyle,
                                        textAlign: TextAlign.center,
                                      )),
                                      color: colorTransparent,
                                    ),
                                    Card(
                                      child: Center(
                                          child: Text(
                                        (widget.size / 1000000).toString()[0] +
                                            (widget.size / 1000000)
                                                .toString()[1] +
                                            (widget.size / 1000000)
                                                .toString()[2] +
                                            ' MB',
                                        style: detailStyle,
                                        textAlign: TextAlign.center,
                                      )),
                                      color: colorTransparent,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
                showFoatingActionButton(false);
                bottomSheetController.closed.then((value) {
                  showFoatingActionButton(true);
                });
              },
            ),
          )
        : Container();
  }

  void showFoatingActionButton(bool value) {
    setState(() {
      showFab = value;
    });
  }
}
