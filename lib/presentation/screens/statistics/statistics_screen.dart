import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Total Users: 100'),
            Text('Active Users: 80'),
            Text('Inactive Users: 20'),
          ],
        ),
      ),
    );
  }
}
