import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_komik/repository/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  AuthBloc(this._authRepo) : super(AuthInitial()) {
    on<Login>((event, emit) async {
      emit(AuthLoading());
      try {
        final userId = await _authRepo.login();
        emit(AuthSuccess(userId: userId));
      } catch (e) {
        emit(AuthError());
      }
    });
    on<Logout>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepo.logout();
        emit(AuthReset());
      } catch (e) {
        emit(AuthError());
      }
    });
  }
}
