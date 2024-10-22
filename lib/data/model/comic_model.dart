class ComicModel {
  final int malId;
  final String images;
  final String englishTitle;
  final String japanTitle;
  final String type;
  final int chapters;
  final int volumes;
  final String status;
  final String publishedWhen;
  final String publishedUntil;
  final double score;
  final int rank;
  final int popularity;
  final int members;
  final int favorites;
  final String synopsis;
  final List authors;
  final List<Genres> genres;

  ComicModel({
    required this.malId,
    required this.images,
    required this.englishTitle,
    required this.japanTitle,
    required this.type,
    required this.chapters,
    required this.volumes,
    required this.status,
    required this.publishedWhen,
    required this.publishedUntil,
    required this.score,
    required this.rank,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.synopsis,
    required this.authors,
    required this.genres,
  });

  factory ComicModel.fromJson(Map<String, dynamic> json) {
    return ComicModel(
      malId: json["mal_id"] ?? 0,
      images: json["images"]["jpg"]["image_url"] ?? "",
      englishTitle: json["title"] ?? "",
      japanTitle: json["title_japanese"] ?? "",
      type: json["type"] ?? "",
      chapters: json["chapters"] ?? 0,
      volumes: json["volumes"] ?? 0,
      status: json["status"] ?? "",
      publishedWhen: json["published"]["from"] ?? "",
      publishedUntil: json["published"]["to"] ?? "",
      score: (json["score"] ?? 0).toDouble(),
      rank: json["rank"] ?? 0,
      popularity: json["popularity"] ?? 0,
      members: json["members"] ?? 0,
      favorites: json["favorites"] ?? 0,
      synopsis: json["synopsis"] ?? "",
      authors: List.from(json["authors"] ?? []),
      genres: List.from(json["genres"].map((e) => Genres.fromJson(e))),
    );
  }
}

class Genres {
  String name;
  Genres({required this.name});

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(name: json["name"]);
  }
}
