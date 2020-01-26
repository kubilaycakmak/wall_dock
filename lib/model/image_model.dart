class ImageModel {
  ImageModel({this.hits});

  final List<Hits> hits;

  factory ImageModel.fromJson(Map<String, dynamic> value) {
    var list = value['hits'] as List;
    List<Hits> hitsList = list.map((i) => Hits.fromJson(i)).toList();
    return ImageModel(
      hits: hitsList,
    );
  }
}

class Hits {
  Hits({this.largeUrl,
    this.type,
    this.webUrl,
    this.user,
    this.likes,
    this.id,
    this.download,
    this.view,
    this.size,
    this.iwidth,
    this.iheight,
    this.comments});

  final String largeUrl, user, webUrl, type;
  final int likes, id, download, view, size, iwidth, iheight, comments;

  factory Hits.fromJson(Map<String, dynamic> value) {
    return Hits(
        largeUrl: value['largeImageURL'],
        webUrl: value['webformatURL'],
        user: value['user'],
        likes: value['likes'],
        id: value['id'],
        download: value['downloads'],
        view: value['views'],
        size: value['imageSize'],
        type: value['type'],
        iwidth: value['imageWidth'],
        iheight: value['imageHeight'],
        comments: value['comments']);
  }
}
