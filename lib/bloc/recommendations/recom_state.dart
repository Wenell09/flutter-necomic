part of 'recom_bloc.dart';

sealed class RecomState extends Equatable {}

final class RecomInitial extends RecomState {
  @override
  List<Object?> get props => [];
}

final class RecomLoading extends RecomState {
  @override
  List<Object?> get props => [];
}

final class RecomLoaded extends RecomState {
  final List<RecomModel> recommendations;
  RecomLoaded({required this.recommendations});
  @override
  List<Object?> get props => [recommendations];
}

final class RecomError extends RecomState {
  @override
  List<Object?> get props => [];
}
