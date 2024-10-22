class CharacterModel {
  final String name, images;

  CharacterModel({required this.name, required this.images});

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      name: json["character"]["name"] ?? "",
      images: json["character"]["images"]["jpg"]["image_url"] ?? "",
    );
  }
}
