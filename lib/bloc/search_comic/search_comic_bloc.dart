import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_komik/data/model/comic_model.dart';
import 'package:flutter_komik/repository/comic_repo.dart';

part 'search_comic_event.dart';
part 'search_comic_state.dart';

class SearchComicBloc extends Bloc<SearchComicEvent, SearchComicState> {
  final ComicRepo _comicRepo;
  SearchComicBloc(this._comicRepo) : super(SearchComicInitial()) {
    on<GetSearchComic>((event, emit) async {
      emit(SearchComicLoading());
      try {
        final comic = await _comicRepo.getSearchComic(event.search);
        emit(SearchComicLoaded(comic: comic));
      } catch (e) {
        emit(SearchComicError());
      }
    });
  }
}
