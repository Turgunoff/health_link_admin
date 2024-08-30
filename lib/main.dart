import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_link_admin/screens/auth/logic/bloc/registration_bloc.dart';
import 'package:health_link_admin/screens/auth/sign_up_screen.dart';
import 'package:health_link_admin/screens/drawer/main_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // RegistrationBloc'ni RepositoryProvider orqali taqdim etish
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => RegistrationBloc()),
      ],
      child: MyApp(),
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
      home: SignUpScreen(),

      // initialRoute: '/', // Boshlang'ich route
      // routes: {
      //   '/': (context) => MainApp(),
      //   '/second': (context) => Second(),
      //   // '/bemorlar': (context) => BemorlarEkrani(),
      //   // ... va hokazo, qolgan ekranlar uchun ham shunga o'xshash
      // },
    );
  }
}
