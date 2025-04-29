class RatingReview {
  final String id;
  final String userId;
  final String productId;
  final int rating;
  final String? review;
  final DateTime createdAt;

  RatingReview({
    required this.id,
    required this.userId,
    required this.productId,
    required this.rating,
    this.review,
    required this.createdAt,
  });

  factory RatingReview.fromJson(Map<String, dynamic> json) {
    return RatingReview(
      id: json['_id'],
      userId: json['userId'],
      productId: json['productId'],
      rating: json['rating'],
      review: json['review'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'userId': userId,
    'productId': productId,
    'rating': rating,
    'review': review,
    'createdAt': createdAt.toIso8601String(),
  };
}
