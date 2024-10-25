part of 'input_bloc.dart';

sealed class InputEvent extends Equatable {}

class ValidationInput extends InputEvent {
  final String value;
  final bool showClearInput;
  ValidationInput({required this.showClearInput, required this.value});
  @override
  List<Object?> get props => [showClearInput, value];
}
