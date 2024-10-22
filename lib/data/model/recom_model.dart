class RecomModel {
  int malId;
  String images, title;

  RecomModel({required this.malId, required this.images, required this.title});

  factory RecomModel.fromJson(Map<String, dynamic> json) {
    return RecomModel(
      malId: json["entry"]["mal_id"] ?? 0,
      images: json["entry"]["images"]["jpg"]["image_url"] ?? "",
      title: json["entry"]["title"] ?? "",
    );
  }
}
