import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'input_event.dart';
part 'input_state.dart';

class InputBloc extends Bloc<InputEvent, InputState> {
  InputBloc() : super(InputState(showClearInput: false, value: "")) {
    on<ValidationInput>((event, emit) {
      emit(
          InputState(showClearInput: event.showClearInput, value: event.value));
    });
  }
}
