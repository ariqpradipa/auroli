import 'package:flutter/material.dart';

import '../models/sleep_data.dart';
import 'date_time_selector.dart';
import 'sleep_duration_display.dart';

class AddSleepDialog extends StatefulWidget {
  final Function(SleepData) onSleepDataAdded;

  const AddSleepDialog({super.key, required this.onSleepDataAdded});

  @override
  State<AddSleepDialog> createState() => _AddSleepDialogState();
}

class _AddSleepDialogState extends State<AddSleepDialog> {
  DateTime? bedTime;
  DateTime? wakeUpTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Sleep Data'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sleep time selector
            DateTimeSelector(
              selectedDateTime: bedTime,
              title: 'Sleep Time',
              placeholder: 'Tap to select sleep time',
              icon: Icons.bedtime,
              iconColor: Colors.indigo,
              onDateTimeSelected: (dateTime) {
                setState(() {
                  bedTime = dateTime;
                  // Reset wake up time if it's before the new bed time
                  if (wakeUpTime != null &&
                      (wakeUpTime!.isBefore(bedTime!) ||
                          wakeUpTime!.isAtSameMomentAs(bedTime!))) {
                    wakeUpTime = null;
                  }
                });
              },
            ),
            const SizedBox(height: 10),

            // Wake up time selector
            DateTimeSelector(
              selectedDateTime: wakeUpTime,
              title: 'Wake up time',
              placeholder: 'Tap to select wake up time',
              icon: Icons.wb_sunny,
              iconColor: Colors.orange,
              onDateTimeSelected: (dateTime) {
                setState(() {
                  wakeUpTime = dateTime;
                });
              },
              validator: (dateTime) {
                return bedTime == null || dateTime.isAfter(bedTime!);
              },
              validationErrorMessage: 'Wake up time must be after sleep time',
            ),

            // Sleep duration display
            if (bedTime != null && wakeUpTime != null) ...[
              const SizedBox(height: 16),
              SleepDurationDisplay(duration: wakeUpTime!.difference(bedTime!)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: bedTime != null && wakeUpTime != null
              ? () {
                  final sleepData = SleepData(
                    bedTime: bedTime!,
                    wakeUpTime: wakeUpTime!,
                  );
                  widget.onSleepDataAdded(sleepData);
                  Navigator.of(context).pop();
                }
              : null,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
