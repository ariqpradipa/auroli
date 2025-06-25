import 'package:flutter/material.dart';

import '../pages/energy_page.dart';
import '../pages/progress_page.dart';
import '../pages/sleep/sleep_page.dart';
import '../providers/theme_provider.dart';

class MainNavigation extends StatefulWidget {
  final ThemeProvider themeProvider;

  const MainNavigation({super.key, required this.themeProvider});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  List<Widget> get _pages => [
    SleepPage(themeProvider: widget.themeProvider),
    EnergyPage(themeProvider: widget.themeProvider),
    ProgressPage(themeProvider: widget.themeProvider),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.bedtime), label: 'Sleep'),
          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Energy'),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}
