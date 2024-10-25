part of 'input_bloc.dart';

class InputState extends Equatable {
  final bool showClearInput;
  final String value;
  // ignore: prefer_const_constructors_in_immutables
  InputState({required this.showClearInput, required this.value});
  @override
  List<Object> get props => [showClearInput, value];
}
