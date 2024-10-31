import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_komik/data/model/user_model.dart';
import 'package:flutter_komik/repository/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo _userRepo;
  UserBloc(this._userRepo) : super(UserInitial()) {
    on<GetUser>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await _userRepo.getDataUser(event.uid);
        emit(UserLoaded(user: user));
      } catch (e) {
        emit(UserError());
      }
    });
  }
}
