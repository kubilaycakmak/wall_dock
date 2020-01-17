import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RandomPage extends StatefulWidget {
  RandomPage({Key key}) : super(key: key);

  @override
  _RandomPageState createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  Random rd = new Random();
  String imageUrl = "https://pixabay.com/api/";

  Future<Map> getPexelsImages() async {
    var response = await http.get(Uri.encodeFull(imageUrl), headers: {
      "authorization": "14951209-61b2f6019e4d1a85e007275aa",
    });
    if(response.statusCode == 200){
      return json.decode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(rd.nextInt(1000));
    return Container(
    );
  }
}