import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wall_dock/bloc.dart';
import 'package:wall_dock/model/image_model.dart';
import 'package:wall_dock/style/color.dart';
import 'full_screen.dart';
import 'style/text.dart';

class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  List<Hits> photos;
  List<int> maxPhotos = [];

  @override
  void initState() {
    super.initState();

    maxPhotos.addAll(List.generate(5000, (index) => index));
    photos = [];
  }

  bool onNotification(ScrollNotification scrollNotification, PhotoBloc bloc) {
    if (scrollNotification is OverscrollNotification) {
      bloc.sink.add(scrollNotification);
    }
    return false;
  }

  Widget buildListView(
      String title, BuildContext context, AsyncSnapshot<List<Hits>> snapshot) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    }
    photos.addAll(snapshot.data);
    return ListView(
      shrinkWrap: false,
      scrollDirection: Axis.vertical,
      physics: AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30, left: 15),
          child: Text(
            title,
            style: titleStyle,
          ),
        ),
        StaggeredGridView.countBuilder(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 20.5, left: 0.5, right: 0.5),
            staggeredTileBuilder: (index) =>
                StaggeredTile.count(2, index.isEven ? 2 : 3),
            crossAxisCount: 4,
            mainAxisSpacing: 0.5,
            crossAxisSpacing: 0.5,
            itemCount: (maxPhotos.length > photos.length)
                ? photos.length + 1
                : photos.length,
            itemBuilder: (context, index) => (index == photos.length)
                ? Container(
                    margin: EdgeInsets.all(8),
                    child: Stack(
                      children: <Widget>[
                        Center(),
                      ],
                    ))
                : Material(
                    color: colorGrayTransparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context) {
                          var fullScreenImage = new FullScreenImage(
                              imgPath: photos[index].largeUrl,
                              user: photos[index].user,
                              likes: photos[index].likes,
                              id: photos[index].id,
                              download: photos[index].download,
                              view: photos[index].view,
                              size: photos[index].size,
                              iwidth: photos[index].iwidth,
                              iheight: photos[index].iheight,
                              comments: photos[index].comments);
                          return fullScreenImage;
                        }));
                      },
                      child: Hero(
                        tag: photos[index].largeUrl,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                  height: 400.0,
                                  width: 300.0,
                                  child: FadeInImage.memoryNetwork(
                                      fit: BoxFit.cover,
                                      placeholder: kTransparentImage,
                                      image: photos[index].webUrl)),
                              Container(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        color: colorDarkTransparent,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                              '@' + photos[index].user,
                                              // '@' + photos[index].user,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  textStyle: TextStyle(
                                                      color: colorGray,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                ),
                                                Text(
                                                  photos[index]
                                                      .likes
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: colorGray),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PhotoBloc>(context);
    return Scaffold(
      backgroundColor: colorGrayTransparent,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) => onNotification(notification, bloc),
        child: StreamBuilder<List<Hits>>(
          stream: bloc.stream,
          builder: (context, AsyncSnapshot<List<Hits>> snapshot) {
            return PageView(
              // onPageChanged: (value) {
              //   if (value == 0) {
              //     setState(() {
              //       typeOfPhoto = 'latest';
              //     });
              //   } else {
              //     setState(() {
              //       typeOfPhoto = 'popular';
              //     });
              //   }
              // },
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                buildListView('latest', context, snapshot),
                // buildListView('popular', context, snapshot)
              ],
            );
          },
        ),
      ),
    );
  }
}
