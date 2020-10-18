import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper({@required this.url});

  Future getData() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}