import '../generic/result_model.dart';

class ApiListResponseWrapper<T> {
  final List<T>? data;
  final Result result;

  ApiListResponseWrapper({this.data, required this.result});

  factory ApiListResponseWrapper.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    return ApiListResponseWrapper(
      data: (json['data'] as List?)?.map((item) => fromJsonT(item)).toList(),
      result: Result.fromJson(json['result'] ?? {}),
    );
  }
}
