import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:health_link_admin/presentation/screens/auth/logic/bloc/auth_bloc.dart';
import 'package:health_link_admin/presentation/screens/splash/splash_screen.dart';
import 'package:health_link_admin/theme/bloc/theme_bloc.dart';
import 'package:health_link_admin/theme/theme.dart';
import 'package:http/http.dart' as http;

import 'data/api/api_constants.dart';

final getIt = GetIt.instance;
void setupLocator() {
  // API clients
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<ApiConstants>(() => ApiConstants());
  // ...

  // Repositories
  // ...

  // BLoCs
  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt<http.Client>()));
  getIt.registerFactory<ThemeBloc>(() => ThemeBloc());

  // Boshqa xizmatlar yoki obyektlar
  // ...
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(
    // BlocProvider orqali RegistrationBloc'ni taqdim etish
    MultiBlocProvider(
      // Use MultiBlocProvider if you have other blocs
      providers: [
        BlocProvider<AuthBloc>(create: (context) => getIt<AuthBloc>()),
        BlocProvider<ThemeBloc>(create: (context) => getIt<ThemeBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Health Link Admin',
          home: const SplashScreen(),
          theme: lightTheme, // Используем вашу светлую тему
          darkTheme: darkTheme, // Используем вашу темную тему
          themeMode: (state is ThemeChanged)
              ? (state.isDarkMode ? ThemeMode.dark : ThemeMode.light)
              : ThemeMode
                  .system, // Используем системную тему по умолчанию, пока состояние не загружено
        );
      },
    );
  }
}
