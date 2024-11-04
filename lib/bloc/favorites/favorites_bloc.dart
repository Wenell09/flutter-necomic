import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_komik/data/model/favorite_model.dart';
import 'package:flutter_komik/repository/favorites_repo.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepo _favoritesRepo;
  FavoritesBloc(this._favoritesRepo) : super(FavoritesInitial()) {
    on<GetFavorites>((event, emit) async {
      emit(FavoritesLoading());
      try {
        final favorites = await _favoritesRepo.getFavorites(event.userId);
        emit(FavoritesLoaded(favorites: favorites));
      } catch (e) {
        emit(FavoritesError());
      }
    });

    on<AddFavorites>((event, emit) async {
      emit(FavoritesLoading());
      try {
        await _favoritesRepo.addFavorites(event.userId, event.malId,
            event.title, event.images, event.type, event.publishedWhen);
        emit(FavoritesAddSuccess(userId: event.userId));
      } catch (e) {
        emit(FavoritesError());
      }
    });

    on<DeleteFavorites>((event, emit) async {
      emit(FavoritesLoading());
      try {
        await _favoritesRepo.deleteFavorites(event.userId, event.malId);
        emit(FavoritesDeleteSuccess(userId: event.userId));
      } catch (e) {
        emit(FavoritesError());
      }
    });
  }
}
