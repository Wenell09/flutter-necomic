part of 'navigation_bloc.dart';

sealed class NavigationEvent extends Equatable {}

class ChangePage extends NavigationEvent {
  final int index;
  ChangePage({required this.index});
  @override
  List<Object?> get props => [index];
}
