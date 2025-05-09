import 'package:generic_services_package/models/generic/money_model.dart';


class Product {
  final String id;
  final String name;
  final Money price;
  final String description;
  final int stock;
  final List<String> images;
  final String category; // Just use ID for Category reference
  final String? subCategory; // Optional
  final int popularity;
  final bool recommended;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.stock,
    required this.images,
    required this.category,
    this.subCategory,
    required this.popularity,
    required this.recommended,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      price: Money.fromJson(json['price']),
      description: json['description'],
      stock: json['stock'],
      images: List<String>.from(json['images']),
      category: json['category'],
      subCategory: json['subCategory'],
      popularity: json['popularity'],
      recommended: json['recommended'],
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'price': price.toJson(),
    'description': description,
    'stock': stock,
    'images': images,
    'category': category,
    'subCategory': subCategory,
    'popularity': popularity,
    'recommended': recommended,
    'CreatedAt': createdAt.toIso8601String(),
    'UpdatedAt': updatedAt.toIso8601String(),
  };
}
