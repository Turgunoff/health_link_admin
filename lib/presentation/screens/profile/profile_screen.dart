import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/images/user.png'),
            const SizedBox(height: 16),
            const Text('John Doe'),
            const SizedBox(height: 8),
            const Text('Software Engineer'),
            const SizedBox(height: 8),
            const Text('Location: New York, USA'),
            const SizedBox(height: 8),
            const Text('Email: johndoe@example.com'),
            const SizedBox(height: 8),
            const Text('Phone: +1 123-456-7890'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add code to navigate to edit profile screen
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
