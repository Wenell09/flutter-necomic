import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(isDark: false)) {
    on<LoadTheme>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool("isDark") ?? false;
      emit(ThemeState(isDark: isDark));
    });
    on<SaveTheme>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("isDark", event.isDark);
      emit(ThemeState(isDark: event.isDark));
    });
  }
}
