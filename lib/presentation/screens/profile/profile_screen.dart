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
            SizedBox(height: 16),
            Text('John Doe'),
            SizedBox(height: 8),
            Text('Software Engineer'),
            SizedBox(height: 8),
            Text('Location: New York, USA'),
            SizedBox(height: 8),
            Text('Email: johndoe@example.com'),
            SizedBox(height: 8),
            Text('Phone: +1 123-456-7890'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add code to navigate to edit profile screen
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
