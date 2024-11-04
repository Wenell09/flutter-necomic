part of 'favorites_bloc.dart';

sealed class FavoritesState extends Equatable {}

final class FavoritesInitial extends FavoritesState {
  @override
  List<Object?> get props => [];
}

final class FavoritesAddSuccess extends FavoritesState {
  final String userId;
  FavoritesAddSuccess({required this.userId});
  @override
  List<Object?> get props => [userId];
}

final class FavoritesDeleteSuccess extends FavoritesState {
  final String userId;
  FavoritesDeleteSuccess({required this.userId});
  @override
  List<Object?> get props => [userId];
}

final class FavoritesLoading extends FavoritesState {
  @override
  List<Object?> get props => [];
}

final class FavoritesLoaded extends FavoritesState {
  final List<FavoriteModel> favorites;
  FavoritesLoaded({required this.favorites});
  @override
  List<Object?> get props => [favorites];
}

final class FavoritesError extends FavoritesState {
  @override
  List<Object?> get props => [];
}
