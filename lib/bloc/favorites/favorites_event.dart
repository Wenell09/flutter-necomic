part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {}

class GetFavorites extends FavoritesEvent {
  final String userId;
  GetFavorites({required this.userId});
  @override
  List<Object?> get props => [userId];
}

class DeleteFavorites extends FavoritesEvent {
  final String userId;
  final int malId;
  DeleteFavorites({required this.userId, required this.malId});
  @override
  List<Object?> get props => [userId, malId];
}

class AddFavorites extends FavoritesEvent {
  final String userId, title, images, type, publishedWhen;
  final int malId;
  AddFavorites({
    required this.userId,
    required this.malId,
    required this.title,
    required this.images,
    required this.type,
    required this.publishedWhen,
  });
  @override
  List<Object?> get props => [
        userId,
        malId,
        title,
        images,
        type,
        publishedWhen,
      ];
}
