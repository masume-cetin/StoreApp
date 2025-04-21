import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class ResourceItem {
  final String? name;
  final dynamic value;
  final String? type;

  ResourceItem({
     this.name,
     this.value,
    this.type
  });

  bool get isImage =>
      value is String && value.toString().startsWith('data:image/');

  Uint8List? get decodedImage {
    try {
      final base64String = value.toString();
      final cleanBase64 = base64String.contains(',')
          ? base64String.split(',').last
          : base64String;
      return base64Decode(cleanBase64);
    } catch (e) {
      debugPrint("❌ Error decoding image: $e");
      return null;
    }
  }


  factory ResourceItem.fromJson(Map<String, dynamic> json) {
    return ResourceItem(
      name: json['name'],
      value: json['value'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'value': value,
        'type' : type
      };
}