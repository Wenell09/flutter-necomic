import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_komik/data/model/review_model.dart';
import 'package:flutter_komik/repository/review_repo.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepo _reviewRepo;
  ReviewBloc(this._reviewRepo) : super(ReviewInitial()) {
    on<AddReview>((event, emit) async {
      try {
        await _reviewRepo.addReview(
          event.title,
          event.userId,
          event.username,
          event.profilePicture,
          event.review,
          event.star,
        );
        emit(ReviewAddSuccess(title: event.title));
      } catch (e) {
        emit(ReviewError());
      }
    });
    on<GetReview>((event, emit) async {
      try {
        final reviews = await _reviewRepo.getReview(event.title);
        emit(ReviewLoaded(reviews: reviews));
      } catch (e) {
        emit(ReviewError());
      }
    });
  }
}
