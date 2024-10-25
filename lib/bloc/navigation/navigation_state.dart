part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  final int index;
  // ignore: prefer_const_constructors_in_immutables
  NavigationState({required this.index});
  @override
  List<Object> get props => [index];
}
