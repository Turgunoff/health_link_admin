import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Version: 1.0.0'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement action for resetting app settings
                print('Resetting app settings...');
              },
              child: const Text('Reset App Settings'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement action for saving settings
          print('Saving settings...');
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
