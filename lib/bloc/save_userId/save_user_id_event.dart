part of 'save_user_id_bloc.dart';

sealed class SaveUserIdEvent extends Equatable {}

class SaveUserId extends SaveUserIdEvent {
  final String userId;
  SaveUserId({required this.userId});
  @override
  List<Object?> get props => [userId];
}

class LoadUserId extends SaveUserIdEvent {
  @override
  List<Object?> get props => [];
}
