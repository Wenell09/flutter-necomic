part of 'top_comic_bloc.dart';

sealed class TopComicEvent extends Equatable {}

class GetTopManhwa extends TopComicEvent {
  final String query;
  GetTopManhwa({required this.query});
  @override
  List<Object?> get props => [query];
}

class GetTopManhua extends TopComicEvent {
  final String query;
  GetTopManhua({required this.query});
  @override
  List<Object?> get props => [query];
}

class GetTopManga extends TopComicEvent {
  final String query;
  GetTopManga({required this.query});
  @override
  List<Object?> get props => [query];
}

class GetTopNovel extends TopComicEvent {
  final String query;
  GetTopNovel({required this.query});
  @override
  List<Object?> get props => [query];
}

class GetTopLightNovel extends TopComicEvent {
  final String query;
  GetTopLightNovel({required this.query});
  @override
  List<Object?> get props => [query];
}
