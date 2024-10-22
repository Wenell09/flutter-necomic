import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_komik/data/model/comic_model.dart';
import 'package:flutter_komik/repository/comic_repo.dart';

part 'top_comic_event.dart';
part 'top_comic_state.dart';

class TopComicBloc extends Bloc<TopComicEvent, TopComicState> {
  final ComicRepo _comicRepo;
  TopComicBloc(this._comicRepo) : super(TopComicInitial()) {
    on<GetTopManga>((event, emit) async {
      emit(TopComicLoading());
      try {
        final manga = await _comicRepo.getTopComic(event.query, "", 1);
        if (state is TopComicLoaded) {
          final currentState = state as TopComicLoaded;
          emit(currentState.copyWith(manga: manga.comicModel));
        } else {
          emit(TopComicLoaded(
              manga: manga.comicModel,
              manhwa: const [],
              manhua: const [],
              novel: const [],
              lightNovel: const []));
        }
      } catch (e) {
        emit(TopComicError());
      }
    });
    on<GetTopManhwa>((event, emit) async {
      emit(TopComicLoading());
      try {
        final manhwa = await _comicRepo.getTopComic(event.query, "", 1);
        if (state is TopComicLoaded) {
          final currentState = state as TopComicLoaded;
          emit(currentState.copyWith(manhwa: manhwa.comicModel));
        } else {
          emit(TopComicLoaded(
              manga: const [],
              manhwa: manhwa.comicModel,
              manhua: const [],
              novel: const [],
              lightNovel: const []));
        }
      } catch (e) {
        emit(TopComicError());
      }
    });
    on<GetTopManhua>((event, emit) async {
      emit(TopComicLoading());
      try {
        final manhua = await _comicRepo.getTopComic(event.query, "", 1);
        if (state is TopComicLoaded) {
          final currentState = state as TopComicLoaded;
          emit(currentState.copyWith(manhua: manhua.comicModel));
        } else {
          emit(TopComicLoaded(
              manga: const [],
              manhwa: const [],
              manhua: manhua.comicModel,
              novel: const [],
              lightNovel: const []));
        }
      } catch (e) {
        emit(TopComicError());
      }
    });
    on<GetTopNovel>((event, emit) async {
      emit(TopComicLoading());
      try {
        final novel = await _comicRepo.getTopComic(event.query, "", 1);
        if (state is TopComicLoaded) {
          final currentState = state as TopComicLoaded;
          emit(currentState.copyWith(novel: novel.comicModel));
        } else {
          emit(TopComicLoaded(
              manga: const [],
              manhwa: const [],
              manhua: const [],
              novel: novel.comicModel,
              lightNovel: const []));
        }
      } catch (e) {
        emit(TopComicError());
      }
    });
    on<GetTopLightNovel>((event, emit) async {
      emit(TopComicLoading());
      try {
        final lightNovel = await _comicRepo.getTopComic(event.query, "", 1);
        if (state is TopComicLoaded) {
          final currentState = state as TopComicLoaded;
          emit(currentState.copyWith(lightNovel: lightNovel.comicModel));
        } else {
          emit(TopComicLoaded(
              manga: const [],
              manhwa: const [],
              manhua: const [],
              novel: const [],
              lightNovel: lightNovel.comicModel));
        }
      } catch (e) {
        emit(TopComicError());
      }
    });
  }
}
