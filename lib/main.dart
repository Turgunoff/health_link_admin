import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_link_admin/screens/auth/logic/bloc/auth_bloc.dart';
import 'package:health_link_admin/screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // BlocProvider orqali RegistrationBloc'ni taqdim etish
    BlocProvider(
      create: (context) => AuthBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: SplashScreen(),
    );
  }
}
// initialRoute: '/', // Boshlang'ich route
// routes: {
//   '/': (context) => MainApp(),
//   '/second': (context) => Second(),
//   // '/bemorlar': (context) => BemorlarEkrani(),
//   // ... va hokazo, qolgan ekranlar uchun ham shunga o'xshash
// },
