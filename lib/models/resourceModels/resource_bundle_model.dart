import 'package:store_app/models/resourceModels/resource_item_model.dart';

class ResourceBundle {
  final String? id;
  final List<ResourceItem>? resource;

  ResourceBundle({
     this.id,
     this.resource,
  });

  factory ResourceBundle.fromJson(Map<String, dynamic> json) {
    return ResourceBundle(
      id: json['_id'],
      resource: (json['resource'] as List)
          .map((item) => ResourceItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'resource': resource?.map((e) => e.toJson()).toList(),
  };
}
