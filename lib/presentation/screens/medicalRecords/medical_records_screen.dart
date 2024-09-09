import 'package:flutter/material.dart';

class MedicalRecordsScreen extends StatelessWidget {
  const MedicalRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Text('Medical Records Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open medical record details
        },
        child: Icon(Icons.add),
      ),
    );
  }
}