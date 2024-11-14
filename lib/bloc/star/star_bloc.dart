import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'star_event.dart';
part 'star_state.dart';

class StarBloc extends Bloc<StarEvent, StarState> {
  StarBloc() : super(StarInitial()) {
    on<AddStar>((event, emit) {
      emit(StarLoaded(index: event.index));
    });
    on<ResetStar>((event, emit) {
      emit(StarReset());
    });
  }
}
