part of 'detail_comic_bloc.dart';

sealed class DetailComicEvent extends Equatable {}

class GetDetail extends DetailComicEvent {
  final int id;
  GetDetail({required this.id});
  @override
  List<Object?> get props => [id];
}
