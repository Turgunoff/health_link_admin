import 'package:flutter/material.dart';
import 'package:health_link_admin/screens/drawer/main_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: MainApp(),

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
