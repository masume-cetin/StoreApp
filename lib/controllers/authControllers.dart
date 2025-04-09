import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_app/models/authModels/userModel.dart';

import '../utils/globalVariables.dart';
class ApiService {
  ApiService._internal();

  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  // Store last HTTP response
  http.Response? _lastResponse;

  // Getter for last response
  http.Response? get lastResponse => _lastResponse;

  Future<Map<String, dynamic>> sendRequest(String endpoint,
      {String method = 'GET', Map<String, dynamic>? body}) async {
    final url = Uri.parse('$uri$endpoint');
    http.Response response;

    try {
      if (method == 'POST') {
        response = await http.post(
          url,
          body: json.encode(body),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'Access-Control-Allow-Origin': '*'
          },
        );
          print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      } else if (method == 'PUT') {
        response = await http.put(
          url,
          body: json.encode(body),
          headers: {'Content-Type': 'application/json'},
        );
      } else if (method == 'DELETE') {
        response = await http.delete(
          url,
          body: json.encode(body),
          headers: {'Content-Type': 'application/json'},
        );
      } else {
        response = await http.get(url);
      }
      _lastResponse = response;
      return json.decode(response.body);
    } catch (e) {
      // Handle error
      return {'error': e};
    }
  }
  dynamic get lastJson {
    if (_lastResponse != null && _lastResponse!.statusCode == 200) {
      return json.decode(_lastResponse!.body);
    }
    return null;
  }
}
