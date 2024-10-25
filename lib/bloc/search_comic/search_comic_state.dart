part of 'search_comic_bloc.dart';

sealed class SearchComicState extends Equatable {}

final class SearchComicInitial extends SearchComicState {
  @override
  List<Object?> get props => [];
}

final class SearchComicLoading extends SearchComicState {
  @override
  List<Object?> get props => [];
}

final class SearchComicLoaded extends SearchComicState {
  final List<ComicModel> comic;
  SearchComicLoaded({required this.comic});
  @override
  List<Object?> get props => [comic];
}

final class SearchComicError extends SearchComicState {
  @override
  List<Object?> get props => [];
}
