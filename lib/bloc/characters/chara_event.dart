part of 'chara_bloc.dart';

sealed class CharaEvent extends Equatable {}

class GetCharacters extends CharaEvent {
  final int id;
  GetCharacters({required this.id});
  @override
  List<Object?> get props => [id];
}
