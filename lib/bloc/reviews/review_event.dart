part of 'review_bloc.dart';

sealed class ReviewEvent extends Equatable {}

class AddReview extends ReviewEvent {
  final String title, userId, username, profilePicture, review;
  final int star;
  AddReview({
    required this.title,
    required this.userId,
    required this.username,
    required this.profilePicture,
    required this.review,
    required this.star,
  });
  @override
  List<Object?> get props => [
        title,
        userId,
        username,
        profilePicture,
        review,
        star,
      ];
}

class GetReview extends ReviewEvent {
  final String title;
  GetReview({required this.title});
  @override
  List<Object?> get props => [title];
}
