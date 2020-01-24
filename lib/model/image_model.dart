class ImageModel{
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

class Hits{

  Hits({this.largeUrl, this.type, this.webUrl, this.user, this.imageWidth, this.imageHeight, this.likes, this.id, this.download, this.view, this.size});
  final String largeUrl, user, webUrl, type;
  final int likes, id, download, view, size, imageWidth, imageHeight;

  factory Hits.fromJson(Map<String, dynamic> value){
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
      imageWidth: value['imageWidth'],
      imageHeight: value['imageHeight']
    );
  }
}