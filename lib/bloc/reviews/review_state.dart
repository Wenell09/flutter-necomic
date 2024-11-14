part of 'review_bloc.dart';

sealed class ReviewState extends Equatable {}

final class ReviewInitial extends ReviewState {
  @override
  List<Object?> get props => [];
}

final class ReviewLoaded extends ReviewState {
  final List<ReviewModel> reviews;
  ReviewLoaded({required this.reviews});
  @override
  List<Object?> get props => [reviews];
}

final class ReviewAddSuccess extends ReviewState {
  final String title;
  ReviewAddSuccess({required this.title});
  @override
  List<Object?> get props => [title];
}

final class ReviewError extends ReviewState {
  @override
  List<Object?> get props => [];
}
