import 'package:flutter/material.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Text(
            'Payments',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 16),
          Text(
            'Select a payment method',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.credit_card, size: 32),
              SizedBox(width: 16),
              Text(
                'Credit Card',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.atm, size: 32),
              SizedBox(width: 16),
              Text(
                'ATM',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.wallet, size: 32),
              SizedBox(width: 16),
              Text(
                'Wallet',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
