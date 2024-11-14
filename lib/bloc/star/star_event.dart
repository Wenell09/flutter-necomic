part of 'star_bloc.dart';

sealed class StarEvent extends Equatable {}

class AddStar extends StarEvent {
  final int index;
  AddStar({required this.index});
  @override
  List<Object?> get props => [index];
}

class ResetStar extends StarEvent {
  @override
  List<Object?> get props => [];
}
