import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Welcome to the Home Screen!'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
