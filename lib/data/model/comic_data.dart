import 'package:flutter_komik/data/model/comic_model.dart';
import 'package:flutter_komik/data/model/pagination_komik.dart';

class ComicData {
  final List<ComicModel> comicModel;
  final PaginationComic paginationComic;

  ComicData({required this.comicModel, required this.paginationComic});

  factory ComicData.fromJson(Map<String, dynamic> json) {
    return ComicData(
      comicModel: List<ComicModel>.from(
          json["data"].map((x) => ComicModel.fromJson(x))),
      paginationComic: PaginationComic.fromJson(json["pagination"]),
    );
  }
}
