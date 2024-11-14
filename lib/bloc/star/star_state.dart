part of 'star_bloc.dart';

sealed class StarState extends Equatable {}

final class StarInitial extends StarState {
  @override
  List<Object?> get props => [];
}

final class StarLoaded extends StarState {
  final int index;
  StarLoaded({required this.index});
  @override
  List<Object?> get props => [index];
}

final class StarReset extends StarState {
  @override
  List<Object?> get props => [];
}
