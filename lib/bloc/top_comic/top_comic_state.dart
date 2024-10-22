part of 'top_comic_bloc.dart';

sealed class TopComicState extends Equatable {}

final class TopComicInitial extends TopComicState {
  @override
  List<Object?> get props => [];
}

final class TopComicLoading extends TopComicState {
  @override
  List<Object?> get props => [];
}

final class TopComicLoaded extends TopComicState {
  final List<ComicModel> manga;
  final List<ComicModel> manhwa;
  final List<ComicModel> manhua;
  final List<ComicModel> novel;
  final List<ComicModel> lightNovel;

  TopComicLoaded({
    required this.manga,
    required this.manhwa,
    required this.manhua,
    required this.novel,
    required this.lightNovel,
  });

  // Metode untuk menggabungkan data
  TopComicLoaded copyWith({
    List<ComicModel>? manga,
    List<ComicModel>? manhwa,
    List<ComicModel>? manhua,
    List<ComicModel>? novel,
    List<ComicModel>? lightNovel,
  }) {
    return TopComicLoaded(
      manga: manga ?? this.manga,
      manhwa: manhwa ?? this.manhwa,
      manhua: manhua ?? this.manhua,
      novel: novel ?? this.novel,
      lightNovel: lightNovel ?? this.lightNovel,
    );
  }

  @override
  List<Object?> get props => [manga, manhwa, manhua, novel, lightNovel];
}

final class TopComicError extends TopComicState {
  @override
  List<Object?> get props => [];
}
