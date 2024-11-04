class FavoriteModel {
  final int malId;
  final String userId, title, images, type, publishedWhen, favoriteDate;

  FavoriteModel({
    required this.malId,
    required this.userId,
    required this.title,
    required this.images,
    required this.type,
    required this.publishedWhen,
    required this.favoriteDate,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      malId: json["mal_id"] ?? 0,
      userId: json["userId"] ?? "",
      title: json["title"] ?? "",
      images: json["images"] ?? "",
      type: json["type"] ?? "",
      publishedWhen: json["published_when"] ?? "",
      favoriteDate: json["favorite_date"] ?? "",
    );
  }
}
