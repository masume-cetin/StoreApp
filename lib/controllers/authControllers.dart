import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_app/models/authModels/userModel.dart';

import '../utils/globalVariables.dart';

class AuthController {
  Future<void> signUpUsers(
      {required context,
      required String email,
      required String password,
      required String fullName}) async {
    try {
      User user = User(email: email, password: password, fullName: fullName);
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(), //convert the user object to request body
          headers: <String, String>{
            //setting the headers for request
            "Content-Type":
                "application/json: charset=UTF-8" //specify the content type as json
          });
    } catch (e) {}
  }
}

class ApiService {
  // final String baseUrl;

  //ApiService({this.baseUrl = 'https://yourapi.com'});

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
            'Access-Control-Allow-Origin': 'http://192.168.1.100:3000'
          },
        );
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

      return json.decode(response.body);
    } catch (e) {
      // Handle error
      return {'error': 'Something went wrong'};
    }
  }
}
