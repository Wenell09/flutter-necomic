part of 'search_comic_bloc.dart';

sealed class SearchComicEvent extends Equatable {}

class GetSearchComic extends SearchComicEvent {
  final String search;
  GetSearchComic({required this.search});
  @override
  List<Object?> get props => [search];
}
