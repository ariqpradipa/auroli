import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/sleep_data.dart';

class SleepDataService {
  static const String _sleepDataKey = 'sleep_data_list';
  static const String _lastBackupKey = 'last_backup_date';
  
  // Singleton pattern for better performance
  static final SleepDataService _instance = SleepDataService._internal();
  factory SleepDataService() => _instance;
  SleepDataService._internal();

  /// Save a list of sleep data to persistent storage
  Future<bool> saveSleepDataList(List<SleepData> sleepDataList) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = sleepDataList.map((data) => data.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      
      await prefs.setString(_sleepDataKey, jsonString);
      await _updateLastBackupDate();
      return true;
    } catch (e) {
      print('Error saving sleep data: $e');
      return false;
    }
  }

  /// Load sleep data list from persistent storage
  Future<List<SleepData>> loadSleepDataList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_sleepDataKey);
      
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }
      
      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => SleepData.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error loading sleep data: $e');
      return [];
    }
  }

  /// Add a single sleep data entry
  Future<bool> addSleepData(SleepData sleepData) async {
    try {
      final currentList = await loadSleepDataList();
      currentList.insert(0, sleepData); // Add to beginning for recent-first order
      return await saveSleepDataList(currentList);
    } catch (e) {
      print('Error adding sleep data: $e');
      return false;
    }
  }

  /// Remove sleep data by index
  Future<bool> removeSleepData(int index) async {
    try {
      final currentList = await loadSleepDataList();
      if (index >= 0 && index < currentList.length) {
        currentList.removeAt(index);
        return await saveSleepDataList(currentList);
      }
      return false;
    } catch (e) {
      print('Error removing sleep data: $e');
      return false;
    }
  }

  /// Update sleep data at a specific index
  Future<bool> updateSleepData(int index, SleepData updatedData) async {
    try {
      final currentList = await loadSleepDataList();
      if (index >= 0 && index < currentList.length) {
        currentList[index] = updatedData;
        return await saveSleepDataList(currentList);
      }
      return false;
    } catch (e) {
      print('Error updating sleep data: $e');
      return false;
    }
  }

  /// Clear all sleep data
  Future<bool> clearAllSleepData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_sleepDataKey);
      await prefs.remove(_lastBackupKey);
      return true;
    } catch (e) {
      print('Error clearing sleep data: $e');
      return false;
    }
  }

  /// Export sleep data as JSON string for backup/sharing
  Future<String?> exportSleepDataAsJson() async {
    try {
      final sleepDataList = await loadSleepDataList();
      final exportData = {
        'version': '1.0',
        'exportDate': DateTime.now().toIso8601String(),
        'totalEntries': sleepDataList.length,
        'sleepData': sleepDataList.map((data) => data.toJson()).toList(),
      };
      return jsonEncode(exportData);
    } catch (e) {
      print('Error exporting sleep data: $e');
      return null;
    }
  }

  /// Import sleep data from JSON string
  Future<bool> importSleepDataFromJson(String jsonString, {bool replaceExisting = false}) async {
    try {
      final importData = jsonDecode(jsonString) as Map<String, dynamic>;
      final sleepDataJson = importData['sleepData'] as List<dynamic>;
      
      final importedSleepData = sleepDataJson
          .map((json) => SleepData.fromJson(json as Map<String, dynamic>))
          .toList();

      if (replaceExisting) {
        return await saveSleepDataList(importedSleepData);
      } else {
        final currentList = await loadSleepDataList();
        currentList.addAll(importedSleepData);
        // Sort by created date to maintain chronological order
        currentList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return await saveSleepDataList(currentList);
      }
    } catch (e) {
      print('Error importing sleep data: $e');
      return false;
    }
  }

  /// Get sleep data statistics
  Future<Map<String, dynamic>> getSleepStatistics() async {
    try {
      final sleepDataList = await loadSleepDataList();
      
      if (sleepDataList.isEmpty) {
        return {
          'totalEntries': 0,
          'averageSleepDuration': Duration.zero,
          'totalSleepTime': Duration.zero,
          'longestSleep': Duration.zero,
          'shortestSleep': Duration.zero,
        };
      }

      final totalSleepTime = sleepDataList.fold<Duration>(
        Duration.zero,
        (sum, data) => sum + data.sleepDuration,
      );

      final averageSleepDuration = Duration(
        milliseconds: totalSleepTime.inMilliseconds ~/ sleepDataList.length,
      );

      final sortedBySleepDuration = sleepDataList
          .map((data) => data.sleepDuration)
          .toList()
        ..sort();

      return {
        'totalEntries': sleepDataList.length,
        'averageSleepDuration': averageSleepDuration,
        'totalSleepTime': totalSleepTime,
        'longestSleep': sortedBySleepDuration.last,
        'shortestSleep': sortedBySleepDuration.first,
        'lastEntry': sleepDataList.first.createdAt,
      };
    } catch (e) {
      print('Error calculating sleep statistics: $e');
      return {};
    }
  }

  /// Get sleep data for a specific date range
  Future<List<SleepData>> getSleepDataInDateRange(DateTime startDate, DateTime endDate) async {
    try {
      final allSleepData = await loadSleepDataList();
      return allSleepData.where((data) {
        return data.bedTime.isAfter(startDate) && data.bedTime.isBefore(endDate);
      }).toList();
    } catch (e) {
      print('Error filtering sleep data by date range: $e');
      return [];
    }
  }

  /// Update the last backup date
  Future<void> _updateLastBackupDate() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_lastBackupKey, DateTime.now().toIso8601String());
    } catch (e) {
      print('Error updating last backup date: $e');
    }
  }

  /// Get the last backup date
  Future<DateTime?> getLastBackupDate() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final dateString = prefs.getString(_lastBackupKey);
      return dateString != null ? DateTime.parse(dateString) : null;
    } catch (e) {
      print('Error getting last backup date: $e');
      return null;
    }
  }

  /// Validate data integrity
  Future<bool> validateDataIntegrity() async {
    try {
      final sleepDataList = await loadSleepDataList();
      for (final data in sleepDataList) {
        if (!data.isValidSleep) {
          return false;
        }
      }
      return true;
    } catch (e) {
      print('Error validating data integrity: $e');
      return false;
    }
  }
}
