import 'dart:convert';

class Review {
  String author;
  String comment;
  double rating;
  Review({
    required this.author,
    required this.comment,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> map) {
    return Review(
      author: map['name'] ?? '',
      comment: map['content'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }
}
