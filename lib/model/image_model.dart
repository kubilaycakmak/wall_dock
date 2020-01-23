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

  Hits({this.largeUrl, this.webUrl, this.user, this.likes, this.id});
  final String largeUrl, user, webUrl;
  final int likes, id;

  factory Hits.fromJson(Map<String, dynamic> value){
    return Hits(
      largeUrl: value['largeImageURL'],
      webUrl: value['webformatURL'],
      user: value['user'],
      likes: value['likes'],
      id: value['id']
    );
  }
}