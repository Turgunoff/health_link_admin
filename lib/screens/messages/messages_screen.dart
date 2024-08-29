import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Messages Screen'),
            Text('Welcome to the Messages Screen'),
            Text('This is a simple chat application built with Flutter'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
