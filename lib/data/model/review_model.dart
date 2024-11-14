class ReviewModel {
  String title, userId, username, profilePicture, review, createdAt;
  int star;
  ReviewModel({
    required this.title,
    required this.userId,
    required this.username,
    required this.profilePicture,
    required this.review,
    required this.star,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      title: json["title"] ?? "",
      userId: json["userId"] ?? "",
      username: json["username"] ?? "",
      profilePicture: json["profile_picture"] ?? "",
      review: json["review"] ?? "",
      star: json["star"] ?? 0,
      createdAt: json["created_at"] ?? "",
    );
  }
}
