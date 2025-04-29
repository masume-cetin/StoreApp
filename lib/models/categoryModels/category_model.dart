import 'sub_category_model.dart';

class Category {
  final String id;
  final String name;
  final String image;
  final String description;
  final List<SubCategory> subCategories;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      subCategories: (json['subCategories'] as List<dynamic>)
          .map((item) => SubCategory.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'image': image,
    'description': description,
    'subCategories': subCategories.map((e) => e.toJson()).toList(),
  };
}
