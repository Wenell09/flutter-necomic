import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_komik/data/model/recom_model.dart';
import 'package:flutter_komik/repository/comic_repo.dart';

part 'recom_event.dart';
part 'recom_state.dart';

class RecomBloc extends Bloc<RecomEvent, RecomState> {
  final ComicRepo _comicRepo;
  RecomBloc(this._comicRepo) : super(RecomInitial()) {
    on<GetRecom>((event, emit) async {
      emit(RecomLoading());
      try {
        final recommendations = await _comicRepo.getRecommendations(event.id);
        emit(RecomLoaded(recommendations: recommendations));
      } catch (e) {
        emit(RecomError());
      }
    });
  }
}
