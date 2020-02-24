import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_camping_app/models/Visitors.dart';
import 'package:http/http.dart' as http;

class GetData {
   static var visitorDataUrl = 'https://haven-tech-test.s3-eu-west-1.amazonaws.com/tech+test+json.json';

  // A function that converts a response body into a List<Visitors>.
  static List<Visitors> _parseVisitors(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Visitors>((json) => Visitors.fromJson(json)).toList();
  }

    static Future<List<Visitors>> fetchVisitors(http.Client client) async {
    final response =
      await client.get(visitorDataUrl);

    return compute(_parseVisitors, response.body);
  }

}
