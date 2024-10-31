part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {}

class Login extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class Logout extends AuthEvent {
  @override
  List<Object?> get props => [];
}
