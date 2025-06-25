# Auroli 🌙✨

An open-source sleep debt and energy tracker inspired by RISE Science, built with Flutter. Auroli helps you understand your sleep patterns and optimize your energy levels using circadian rhythm science.

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

> **⚠️ Early Development:** This project is currently in early development. Features and APIs may change frequently.

## 🌟 Features

### Current Features

- **Sleep Tracking**: Log your bedtime and wake time with persistent storage
- **Sleep Debt Calculation**: Track your accumulated sleep debt over time
- **Energy Tracking**: Monitor your daily energy levels throughout the day
- **Progress Monitoring**: Visualize your sleep patterns and trends
- **Cross-Platform**: Works on iOS and Android

### Planned Features

- **Circadian Rhythm Analysis**: Advanced algorithms to predict optimal sleep/wake times
- **Smart Notifications**: Intelligent reminders based on your sleep schedule
- **Sleep Quality Metrics**: Detailed analysis of sleep efficiency and quality
- **Integration Support**: Connect with popular fitness trackers and health apps
- **Export Capabilities**: Export your sleep data for analysis
- **Personalized Insights**: AI-powered recommendations for better sleep

## 🏗️ Architecture

Auroli follows a clean, modular architecture:

```
lib/
├── main.dart                 # App entry point
├── pages/                    # Screen components
│   ├── sleep/               # Sleep tracking module
│   │   ├── models/          # Data models
│   │   ├── services/        # Business logic
│   │   └── widgets/         # Sleep-specific UI components
│   ├── energy_page.dart     # Energy tracking
│   ├── progress_page.dart   # Analytics and trends
│   ├── account_page.dart    # User profile
│   └── settings_page.dart   # App settings
├── providers/               # State management
│   └── theme_provider.dart  # Theme management
└── widgets/                 # Shared UI components
    └── main_navigation.dart # Bottom navigation
```

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.8.1 or higher)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- iOS Simulator / Android Emulator or physical device

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/auroli.git
   cd auroli
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Development Setup

1. **Check Flutter installation**

   ```bash
   flutter doctor
   ```

2. **For iOS development** (macOS only)

   ```bash
   cd ios
   pod install
   ```

3. **Run in debug mode**
   ```bash
   flutter run --debug
   ```

## 📱 Screenshots

_Screenshots coming soon as the app develops..._

## 🧪 Testing

Run the test suite:

```bash
flutter test
```

For widget tests with coverage:

```bash
flutter test --coverage
```

## 🤝 Contributing

We welcome contributions! This project aims to be a community-driven alternative to commercial sleep tracking apps.

### How to Contribute

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit your changes**
   ```bash
   git commit -m 'Add some amazing feature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/amazing-feature
   ```
5. **Open a Pull Request**

### Development Guidelines

- Follow [Flutter style guide](https://docs.flutter.dev/development/tools/formatting)
- Write tests for new features
- Update documentation as needed
- Keep commit messages clear and descriptive

## 📊 Project Status

- [x] Basic app structure and navigation
- [x] Sleep tracking with persistent storage
- [x] Theme management (dark/light mode)
- [x] Basic energy tracking interface
- [ ] Sleep debt calculation algorithms
- [ ] Circadian rhythm analysis
- [ ] Data visualization and charts
- [ ] Export functionality
- [ ] Notification system
- [ ] Health app integrations

## 🔬 Science Behind Auroli

Auroli is built on established sleep science principles:

- **Sleep Debt**: Tracks the difference between your sleep need and actual sleep
- **Circadian Rhythms**: Considers your natural body clock for optimal timing
- **Energy Prediction**: Uses sleep quality and timing to predict energy levels
- **Individual Variation**: Adapts to your personal sleep patterns over time

## 📚 Documentation

- [Sleep Storage Implementation](docs/sleep-storage.md) - Technical details about data persistence
- [API Documentation](docs/api.md) - _Coming soon_
- [Architecture Guide](docs/architecture.md) - _Coming soon_

## 🛠️ Built With

- **[Flutter](https://flutter.dev)** - UI framework
- **[Dart](https://dart.dev)** - Programming language
- **[SharedPreferences](https://pub.dev/packages/shared_preferences)** - Local data storage
- **Material Design 3** - Design system

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by [RISE Science](https://www.risescience.com/) for their pioneering work in sleep science
- Flutter community for excellent documentation and packages
- Sleep research community for scientific foundations

## 📞 Contact

- **Issues**: [GitHub Issues](https://github.com/yourusername/auroli/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/auroli/discussions)

---

**Made with ❤️ for better sleep and energy optimization**
