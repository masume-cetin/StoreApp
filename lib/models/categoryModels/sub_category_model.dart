class SubCategory {
  final String id;
  final String name;
  final String image;
  final String description;
  final String parentCategory; // <-- important!

  SubCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.parentCategory,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      parentCategory: json['parentCategory'], // 💥
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'image': image,
    'description': description,
    'parentCategory': parentCategory,
  };
}
