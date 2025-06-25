import 'package:flutter/material.dart';

import '../providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  final ThemeProvider themeProvider;

  const SettingsPage({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 16),
          _buildSectionTitle('Appearance'),
          const SizedBox(height: 8),
          _buildThemeSelector(context),
          const SizedBox(height: 32),
          _buildSectionTitle('About'),
          const SizedBox(height: 8),
          _buildAboutSection(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('Theme'),
            subtitle: Text(_getThemeText(themeProvider.themeOption)),
          ),
          const Divider(height: 1),
          _buildThemeOption(
            context,
            ThemeOption.light,
            'Light',
            Icons.light_mode,
          ),
          _buildThemeOption(context, ThemeOption.dark, 'Dark', Icons.dark_mode),
          _buildThemeOption(
            context,
            ThemeOption.system,
            'System',
            Icons.settings_brightness,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    ThemeOption option,
    String title,
    IconData icon,
  ) {
    final isSelected = themeProvider.themeOption == option;

    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: isSelected
          ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
          : null,
      onTap: () => themeProvider.setTheme(option),
      selected: isSelected,
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Auroli'),
            subtitle: const Text('Version 1.0.0'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showAboutDialog(context),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Implement privacy policy navigation
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy Policy - Coming Soon')),
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Implement terms of service navigation
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Terms of Service - Coming Soon')),
              );
            },
          ),
        ],
      ),
    );
  }

  String _getThemeText(ThemeOption option) {
    switch (option) {
      case ThemeOption.light:
        return 'Light mode';
      case ThemeOption.dark:
        return 'Dark mode';
      case ThemeOption.system:
        return 'Follow system setting';
    }
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Auroli',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        Icons.energy_savings_leaf,
        size: 48,
        color: Colors.deepPurple,
      ),
      children: [
        const Text(
          'Auroli helps you track your energy, sleep, and progress towards a healthier lifestyle.',
        ),
      ],
    );
  }
}
