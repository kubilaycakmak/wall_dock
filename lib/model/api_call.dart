import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wall_dock/model/image_model.dart';

ImageModel imageModel;
var response;

Future<Map> getPexelLatest(int perPage, int pageNumer, _) async {
  if (response == null) {
    response = await http.get(Uri.encodeFull(
        "https://pixabay.com/api/?key=14951209-61b2f6019e4d1a85e007275aa" +
            "&order=latest&page=$pageNumer&per_page=$perPage&editors_choice=true&category=$_&orientation=vertical"));
  }
  if (response.statusCode == 200) {
    var image = json.decode(response.body);
    imageModel = new ImageModel.fromJson(image);
    return json.decode(response.body);
  }
}

Future<Map> getPexelPopular(int perPage, int pageNumer, _) async {
  if (response == null) {
    response = await http.get(Uri.encodeFull(
        "https://pixabay.com/api/?key=14951209-61b2f6019e4d1a85e007275aa" +
            "&order=popular&page=$pageNumer&per_page=$perPage&editors_choice=true&category=$_&orientation=vertical"));
  }
  if (response.statusCode == 200) {
    var image = json.decode(response.body);
    imageModel = new ImageModel.fromJson(image);
    return json.decode(response.body);
  }
}
