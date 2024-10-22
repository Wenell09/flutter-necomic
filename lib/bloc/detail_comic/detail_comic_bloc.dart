import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_komik/data/model/comic_model.dart';
import 'package:flutter_komik/repository/comic_repo.dart';
part 'detail_comic_event.dart';
part 'detail_comic_state.dart';

class DetailComicBloc extends Bloc<DetailComicEvent, DetailComicState> {
  final ComicRepo _comicRepo;
  DetailComicBloc(this._comicRepo) : super(DetailComicInitial()) {
    on<GetDetail>((event, emit) async {
      emit(DetailComicLoading());
      try {
        final detailComic = await _comicRepo.getDetailComic(event.id);
        emit(DetailComicLoaded(detailComic: detailComic));
      } catch (e) {
        emit(DetailComicError());
      }
    });
  }
}
