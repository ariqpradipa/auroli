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
  final SleepDataService _sleepDataService = SleepDataService();
  bool _isLoading = true;
  Map<String, dynamic> _sleepStatistics = {};

  @override
  void initState() {
    super.initState();
    _loadSleepData();
  }

  Future<void> _loadSleepData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final loadedData = await _sleepDataService.loadSleepDataList();
      final statistics = await _sleepDataService.getSleepStatistics();

      setState(() {
        _sleepDataList.clear();
        _sleepDataList.addAll(loadedData);
        _sleepStatistics = statistics;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading sleep data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Remove sleep data entry with confirmation
  Future<void> _confirmAndRemoveSleepData(int index) async {
    if (index < 0 || index >= _sleepDataList.length) return;

    final sleepData = _sleepDataList[index];
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Sleep Entry'),
          content: Text(
            'Are you sure you want to delete this sleep entry?\n\n'
            'Sleep: ${sleepData.formattedBedTime}\n'
            'Wake: ${sleepData.formattedWakeUpTime}\n'
            'Duration: ${sleepData.formattedDuration}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _removeSleepData(index);
    }
  }

  /// Remove sleep data entry
  Future<void> _removeSleepData(int index) async {
    try {
      final success = await _sleepDataService.removeSleepData(index);

      if (success) {
        // Reload data and statistics
        await _loadSleepData();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sleep data removed successfully!'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to remove sleep data. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error removing sleep data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Refresh data from storage
  Future<void> _refreshData() async {
    try {
      await _loadSleepData();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error refreshing sleep data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Header section
                    const SleepPageHeader(),
                    const SizedBox(height: 40),

                    // Add Sleep Data Section
                    AddSleepDataCard(
                      onAddPressed: () => _showAddSleepDialog(context),
                    ),

                    const SizedBox(height: 20),

                    // Sleep Statistics Section
                    SleepStatisticsCard(statistics: _sleepStatistics),

                    const SizedBox(height: 20),

                    // Recent Sleep Data Section
                    RecentSleepDataCard(
                      sleepData: _sleepDataList,
                      onDeleteItem: _confirmAndRemoveSleepData,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _showAddSleepDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddSleepDialog(
          onSleepDataAdded: (sleepData) async {
            // Show loading indicator
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Row(
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: 16),
                    Text('Saving sleep data...'),
                  ],
                ),
                duration: Duration(seconds: 1),
              ),
            );

            try {
              // Save to persistent storage
              final success = await _sleepDataService.addSleepData(sleepData);

              if (success) {
                // Reload data and statistics
                await _loadSleepData();

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sleep data saved successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Failed to save sleep data. Please try again.',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error saving sleep data: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
        );
      },
    );
  }
}
