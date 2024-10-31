part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {}

class GetUser extends UserEvent {
  final String uid;
  GetUser({required this.uid});
  @override
  List<Object?> get props => [uid];
}
