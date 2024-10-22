import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_komik/data/model/character_model.dart';
import 'package:flutter_komik/repository/comic_repo.dart';

part 'chara_event.dart';
part 'chara_state.dart';

class CharaBloc extends Bloc<CharaEvent, CharaState> {
  final ComicRepo _comicRepo;
  CharaBloc(this._comicRepo) : super(CharaInitial()) {
    on<GetCharacters>((event, emit) async {
      emit(CharaLoading());
      try {
        final characters = await _comicRepo.getCharacters(event.id);
        emit(CharaLoaded(characters: characters));
      } catch (e) {
        emit(CharaError());
      }
    });
  }
}
