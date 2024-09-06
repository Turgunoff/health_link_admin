import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_link_admin/screens/auth/logic/bloc/auth_bloc.dart';
import 'package:health_link_admin/screens/splash/splash_screen.dart';
import 'package:health_link_admin/theme/bloc/theme_bloc.dart';
import 'package:health_link_admin/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // BlocProvider orqali RegistrationBloc'ni taqdim etish
    MultiBlocProvider(
      // Use MultiBlocProvider if you have other blocs
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
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
          title: 'My App',
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
