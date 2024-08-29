import 'package:flutter/material.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Patient Records'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement add patient functionality here
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
