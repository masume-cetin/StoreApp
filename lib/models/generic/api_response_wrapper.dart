import 'package:store_app/models/generic/result_model.dart';

class ApiResponse<T> {
  final T? data;
  final Result result;

  ApiResponse({this.data, required this.result});

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic) fromJsonT,
      ) {
    return ApiResponse(
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      result: Result.fromJson(json['result'] ?? {}),
    );
  }
}
