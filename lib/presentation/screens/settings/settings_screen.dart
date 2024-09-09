import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Version: 1.0.0'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement action for resetting app settings
                print('Resetting app settings...');
              },
              child: Text('Reset App Settings'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement action for saving settings
          print('Saving settings...');
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
