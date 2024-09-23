import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Help Screen'),
            SizedBox(height: 20),
            Text(
                'This is the help screen. Here you can find instructions on how to use the app.'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
