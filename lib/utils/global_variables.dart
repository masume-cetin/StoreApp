import 'package:flutter_dotenv/flutter_dotenv.dart';

String uri = dotenv.env['BASE_URL']  ?? 'http://localhost:3000';
String signUp = "/api/signup";
String signIn = "/api/signin";
String getResourcesApi = "/api/resources/get";
String getResourceByNameApi = "/api/resources/getByName";
String getCategories = "/api/categories";