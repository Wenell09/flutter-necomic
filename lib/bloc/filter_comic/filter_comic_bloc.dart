import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_komik/data/model/comic_model.dart';
import 'package:flutter_komik/data/model/pagination_komik.dart';
import 'package:flutter_komik/repository/comic_repo.dart';

part 'filter_comic_event.dart';
part 'filter_comic_state.dart';

class FilterComicBloc extends Bloc<FilterComicEvent, FilterComicState> {
  final ComicRepo _comicRepo;
  FilterComicBloc(this._comicRepo) : super(FilterComicInitial()) {
    on<GetFilterComic>((event, emit) async {
      emit(FilterComicLoading());
      try {
        final data =
            await _comicRepo.getTopComic(event.query, event.filter, event.page);
        emit(FilterComicLoaded(
            comic: data.comicModel, paginationcomic: data.paginationComic));
      } catch (e) {
        emit(FilterComicError());
      }
    });
  }
}
