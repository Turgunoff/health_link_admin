import 'package:flutter/material.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Your appointments'),
            ElevatedButton(
              onPressed: () {
                // Navigate to the AddAppointmentScreen
              },
              child: const Text('Add Appointment'),
            ),
            // Add more appointments as needed
            //...
          ],
        ),
      ),
    );
  }
}
