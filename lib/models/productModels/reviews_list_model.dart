import 'package:store_app/models/productModels/rating_review_model.dart';

class RatingReviewList {
  final List<RatingReview>? reviewList;

  RatingReviewList({this.reviewList});

  factory RatingReviewList.fromJson(Map<String, dynamic> json) {
    return RatingReviewList(
      reviewList: (json['review'] as List?)?.map((item) => RatingReview.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'review': reviewList?.map((e) => e.toJson()).toList(),
  };
}
