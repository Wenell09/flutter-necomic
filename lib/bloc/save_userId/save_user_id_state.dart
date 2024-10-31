part of 'save_user_id_bloc.dart';

sealed class SaveUserIdState extends Equatable {}

final class SaveUserIdInitial extends SaveUserIdState {
  @override
  List<Object?> get props => [];
}

final class SaveUserLoaded extends SaveUserIdState {
  final String userId;
  SaveUserLoaded({required this.userId});
  @override
  List<Object?> get props => [userId];
}

final class SaveUserEmpty extends SaveUserIdState {
  @override
  List<Object?> get props => [];
}
