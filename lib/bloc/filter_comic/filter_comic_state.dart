part of 'filter_comic_bloc.dart';

sealed class FilterComicState extends Equatable {}

final class FilterComicInitial extends FilterComicState {
  @override
  List<Object?> get props => [];
}

final class FilterComicLoading extends FilterComicState {
  @override
  List<Object?> get props => [];
}

final class FilterComicLoaded extends FilterComicState {
  final List<ComicModel> comic;
  final PaginationComic paginationcomic;

  FilterComicLoaded({required this.comic, required this.paginationcomic});
  @override
  List<Object?> get props => [comic, paginationcomic];
}

final class FilterComicError extends FilterComicState {
  @override
  List<Object?> get props => [];
}
