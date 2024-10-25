import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(index: 0)) {
    on<ChangePage>((event, emit) {
      emit(NavigationState(index: event.index));
    });
  }
}
