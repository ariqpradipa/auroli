import 'package:flutter/material.dart';

class SleepPageHeader extends StatelessWidget {
  const SleepPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Icon(Icons.bedtime, size: 80, color: Colors.indigo),
          SizedBox(height: 24),
          Text(
            'Sleep Tracking',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Track your sleep patterns and improve your rest quality.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
