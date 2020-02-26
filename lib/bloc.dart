import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wall_dock/tools/load.dart';
import 'model/api_call.dart';
import 'model/image_model.dart';

class PhotoBloc {
  final API api = API();
  int pageNumber = 1;
  double pixels = 0.0;
  String typeOfPhoto;
  Timer t;

  ReplaySubject<List<Hits>> _subject = ReplaySubject();
  final ReplaySubject<ScrollNotification> _controller = ReplaySubject();

  Observable<List<Hits>> get stream => _subject.stream;
  Sink<ScrollNotification> get sink => _controller.sink;

  PhotoBloc() {
    _subject.addStream(Observable.fromFuture(
        api.getPixelImage(25, pageNumber, null, 'latest')));

    _controller.listen((event) => loadPhotos(event));
  }

  void dispose() {
    _controller.close();
    _subject.close();
  }

  Future<void> loadPhotos([
    ScrollNotification notification, BuildContext context
  ]) async {
    if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
      pixels = notification.metrics.pixels;
      pageNumber++;
      List<Hits> list = await api.getPixelImage(25, pageNumber, null, 'latest');
      _subject.sink.add(list);
    }
  }
}
