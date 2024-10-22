part of 'chara_bloc.dart';

sealed class CharaState extends Equatable {}

final class CharaInitial extends CharaState {
  @override
  List<Object?> get props => [];
}

final class CharaLoading extends CharaState {
  @override
  List<Object?> get props => [];
}

final class CharaLoaded extends CharaState {
  final List<CharacterModel> characters;
  CharaLoaded({required this.characters});
  @override
  List<Object?> get props => [characters];
}

final class CharaError extends CharaState {
  @override
  List<Object?> get props => [];
}
