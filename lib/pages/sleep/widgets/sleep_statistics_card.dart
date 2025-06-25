import 'package:flutter/material.dart';

class SleepStatisticsCard extends StatelessWidget {
  final Map<String, dynamic> statistics;

  const SleepStatisticsCard({super.key, required this.statistics});

  @override
  Widget build(BuildContext context) {
    if (statistics.isEmpty || statistics['totalEntries'] == 0) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sleep Statistics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildStatisticRow(
              'Total Entries', 
              '${statistics['totalEntries']}',
              Icons.analytics,
            ),
            _buildStatisticRow(
              'Average Sleep', 
              _formatDuration(statistics['averageSleepDuration']),
              Icons.access_time,
            ),
            _buildStatisticRow(
              'Longest Sleep', 
              _formatDuration(statistics['longestSleep']),
              Icons.trending_up,
            ),
            _buildStatisticRow(
              'Shortest Sleep', 
              _formatDuration(statistics['shortestSleep']),
              Icons.trending_down,
            ),
            _buildStatisticRow(
              'Total Sleep Time', 
              _formatDuration(statistics['totalSleepTime']),
              Icons.bedtime,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration? duration) {
    if (duration == null || duration == Duration.zero) return '0h 0m';
    
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }
}
