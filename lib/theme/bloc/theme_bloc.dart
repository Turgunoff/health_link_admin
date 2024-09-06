import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ToggleThemeEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      bool isDarkMode = prefs.getBool('isDarkMode') ??
          false; // Get current theme or default to light

      isDarkMode = !isDarkMode; // Toggle the theme
      await prefs.setBool('isDarkMode', isDarkMode); // Save the new preference

      emit(ThemeChanged(isDarkMode: isDarkMode));
    });
    on<LoadThemeEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
      emit(ThemeChanged(isDarkMode: isDarkMode));
    });

    // Запрашиваем загрузку темы при создании блока
    add(LoadThemeEvent());
  }
}
