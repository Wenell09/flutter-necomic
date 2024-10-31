part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {}

class SaveTheme extends ThemeEvent {
  final bool isDark;
  SaveTheme({required this.isDark});
  @override
  List<Object?> get props => [isDark];
}

class LoadTheme extends ThemeEvent {
  @override
  List<Object?> get props => [];
}
