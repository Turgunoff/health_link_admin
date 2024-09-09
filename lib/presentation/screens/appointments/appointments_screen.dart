import 'package:flutter/material.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Your appointments'),
            ElevatedButton(
              onPressed: () {
                // Navigate to the AddAppointmentScreen
              },
              child: Text('Add Appointment'),
            ),
            // Add more appointments as needed
            //...
          ],
        ),
      ),
    );
  }
}
