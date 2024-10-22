part of 'recom_bloc.dart';

sealed class RecomEvent extends Equatable {}

class GetRecom extends RecomEvent {
  final int id;
  GetRecom({required this.id});
  @override
  List<Object?> get props => [id];
}
