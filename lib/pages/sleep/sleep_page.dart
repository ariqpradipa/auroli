import 'package:flutter/material.dart';

import '../../providers/theme_provider.dart';
import '../account_page.dart';
import 'sleep_exports.dart';

class SleepPage extends StatefulWidget {
  final ThemeProvider themeProvider;

  const SleepPage({super.key, required this.themeProvider});

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  final List<SleepData> _sleepDataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        AccountPage(themeProvider: widget.themeProvider),
                  ),
                );
              },
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.deepPurple,
                child: Icon(Icons.person, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header section
            const SleepPageHeader(),
            const SizedBox(height: 40),

            // Add Sleep Data Section
            AddSleepDataCard(onAddPressed: () => _showAddSleepDialog(context)),

            const SizedBox(height: 20),

            // Recent Sleep Data Section
            RecentSleepDataCard(sleepData: _sleepDataList),
          ],
        ),
      ),
    );
  }

  void _showAddSleepDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddSleepDialog(
          onSleepDataAdded: (sleepData) {
            setState(() {
              _sleepDataList.insert(0, sleepData);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sleep data saved successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          },
        );
      },
    );
  }
}
