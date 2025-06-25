# Sleep Module

This module contains all components related to sleep tracking functionality.

## Structure

```
sleep/
├── sleep_page.dart               # Main sleep page widget
├── models/
│   └── sleep_data.dart           # Sleep data model with validation and formatting
├── widgets/
│   ├── sleep_page_header.dart    # Header widget with title and description
│   ├── add_sleep_data_card.dart  # Card widget for adding new sleep data
│   ├── recent_sleep_data_card.dart # Card widget displaying recent sleep entries
│   ├── add_sleep_dialog.dart     # Dialog for adding sleep data
│   ├── date_time_selector.dart   # Reusable date/time picker widget
│   └── sleep_duration_display.dart # Widget to display sleep duration
├── sleep_exports.dart            # Barrel export file for clean imports
└── README.md                     # This documentation file
```

## Components

### Models

- **SleepData**: Represents a sleep entry with bed time, wake up time, duration calculation, and formatting methods.

### Widgets

- **SleepPageHeader**: Displays the page title, icon, and description.
- **AddSleepDataCard**: Contains the "Log Your Sleep" section with the add button.
- **RecentSleepDataCard**: Shows a list of recent sleep entries or empty state.
- **AddSleepDialog**: Modal dialog for adding new sleep data with validation.
- **DateTimeSelector**: Reusable widget for selecting date and time with validation support.
- **SleepDurationDisplay**: Displays calculated sleep duration in a styled container.

## Usage

Import the sleep module using the barrel export:

```dart
// For using individual components
import 'pages/sleep/sleep_exports.dart';

// Or import the main page directly
import 'pages/sleep/sleep_page.dart';
```

The sleep module is now completely self-contained within its own folder, making it easy to maintain and potentially extract as a separate package if needed.

## Features

- ✅ Modular component structure
- ✅ Reusable widgets
- ✅ Input validation
- ✅ Clean separation of concerns
- ✅ Type-safe data models
- ✅ Responsive UI components
- ✅ Error handling and user feedback

## Best Practices Implemented

1. **Single Responsibility**: Each widget has a single, well-defined purpose
2. **Composition over Inheritance**: Uses composition to build complex UIs
3. **Separation of Concerns**: Models, widgets, and business logic are separated
4. **Reusability**: Components can be reused across different contexts
5. **Type Safety**: Strong typing with proper data models
6. **Clean Imports**: Barrel exports for cleaner import statements
7. **Documentation**: Well-documented code and structure
