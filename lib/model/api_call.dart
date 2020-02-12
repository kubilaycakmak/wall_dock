import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:wall_dock/model/image_model.dart';

class API {
  Future<List<Hits>> getPixelImage(
      int perPage, int pageNumer, _, String type) async {
    final response = await http.get(Uri.encodeFull(
        "https://pixabay.com/api/?key=14951209-61b2f6019e4d1a85e007275aa" +
            "&order=$type&page=$pageNumer&per_page=$perPage&editors_choice=true&category=$_&orientation=vertical&min_width=${window.physicalSize.width}&min_height=${window.physicalSize.height}"));
    List jsonData = json.decode(response.body)['hits'];
    return jsonData.map((e) => Hits.fromJson(e)).toList();
  }
}

// Future<Map> getPexelPopular(int perPage, int pageNumer, _) async {
//   if (response == null) {
//     response = await http.get(Uri.encodeFull(
//         "https://pixabay.com/api/?key=14951209-61b2f6019e4d1a85e007275aa" +
//             "&order=popular&page=$pageNumer&per_page=$perPage&editors_choice=true&category=$_&orientation=vertical"));
//   }
//   if (response.statusCode == 200) {
//     var image = json.decode(response.body);
//     imageModel = new ImageModel.fromJson(image);
//     return json.decode(response.body);
//   }
// }
