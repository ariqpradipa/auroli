import 'package:flutter/material.dart';

class DateTimeSelector extends StatelessWidget {
  final DateTime? selectedDateTime;
  final String title;
  final String placeholder;
  final IconData icon;
  final Color iconColor;
  final Function(DateTime) onDateTimeSelected;
  final bool Function(DateTime)? validator;
  final String? validationErrorMessage;

  const DateTimeSelector({
    super.key,
    required this.selectedDateTime,
    required this.title,
    required this.placeholder,
    required this.icon,
    required this.iconColor,
    required this.onDateTimeSelected,
    this.validator,
    this.validationErrorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, color: iconColor),
            title: Text(title),
            subtitle: Text(
              selectedDateTime != null
                  ? _formatDateTime(selectedDateTime!)
                  : placeholder,
            ),
            onTap: () => _selectDateTime(context),
          ),
          if (selectedDateTime != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.calendar_today, size: 16),
                      label: const Text('Date', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () => _selectTime(context),
                      icon: const Icon(Icons.access_time, size: 16),
                      label: const Text('Time', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );

    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: selectedDateTime != null
            ? TimeOfDay.fromDateTime(selectedDateTime!)
            : TimeOfDay.now(),
      );

      if (time != null) {
        final newDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        if (validator != null && !validator!(newDateTime)) {
          if (validationErrorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(validationErrorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }

        onDateTimeSelected(newDateTime);
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    if (selectedDateTime == null) return;

    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDateTime!,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );

    if (date != null) {
      final newDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        selectedDateTime!.hour,
        selectedDateTime!.minute,
      );

      if (validator != null && !validator!(newDateTime)) {
        if (validationErrorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(validationErrorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      onDateTimeSelected(newDateTime);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    if (selectedDateTime == null) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime!),
    );

    if (time != null) {
      final newDateTime = DateTime(
        selectedDateTime!.year,
        selectedDateTime!.month,
        selectedDateTime!.day,
        time.hour,
        time.minute,
      );

      if (validator != null && !validator!(newDateTime)) {
        if (validationErrorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(validationErrorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      onDateTimeSelected(newDateTime);
    }
  }
}
