import 'package:store_app/models/generic/resultModel.dart';

class ApiResponse<T> {
  final T? data;
  final Result result;

  ApiResponse({this.data, required this.result});
}

