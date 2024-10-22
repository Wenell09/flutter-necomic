part of 'detail_comic_bloc.dart';

sealed class DetailComicState extends Equatable {}

final class DetailComicInitial extends DetailComicState {
  @override
  List<Object?> get props => [];
}

final class DetailComicLoading extends DetailComicState {
  @override
  List<Object?> get props => [];
}

final class DetailComicLoaded extends DetailComicState {
  final ComicModel detailComic;
  DetailComicLoaded({required this.detailComic});
  @override
  List<Object?> get props => [detailComic];
}

final class DetailComicError extends DetailComicState {
  @override
  List<Object?> get props => [];
}
