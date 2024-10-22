part of 'filter_comic_bloc.dart';

sealed class FilterComicEvent extends Equatable {}

class GetFilterComic extends FilterComicEvent {
  final String query;
  final String filter;
  final int page;

  GetFilterComic(
      {required this.query, required this.filter, required this.page});

  @override
  List<Object?> get props => [query, filter, page];
}
