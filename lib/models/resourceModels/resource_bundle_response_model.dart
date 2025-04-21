import 'package:store_app/models/resourceModels/resource_bundle_model.dart';

import '../generic/result_model.dart';

class ResourceBundleResponse {
  final List<ResourceBundle> data;
  final Result result;

  ResourceBundleResponse({required this.data, required this.result});

  factory ResourceBundleResponse.fromJson(Map<String, dynamic> json) {
    return ResourceBundleResponse(
      data: (json['data'] as List)
          .map((item) => ResourceBundle.fromJson(item))
          .toList(),
      result: Result.fromJson(json['result'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data.map((e) => e.toJson()).toList(),
    'result': result.toJson(),
  };
}