import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wall_dock/model/image_model.dart';
ImageModel imageModel;
var response;
Future<Map> getPexelsImages(int perPage, int pageNumer, var response, String order) async {
    if (response == null) {
      response = await http.get(Uri.encodeFull(
          "https://pixabay.com/api/?key=14951209-61b2f6019e4d1a85e007275aa"+
          "&order=$order&page=$pageNumer&per_page=$perPage&editors_choice=true"));
    }
    if (response.statusCode == 200) {
      var image = json.decode(response.body);
      imageModel = new ImageModel.fromJson(image);
      return json.decode(response.body);
    }
  }