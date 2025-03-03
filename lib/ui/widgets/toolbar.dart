import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/config/application.dart';
import 'package:simple_currency/domain/di/providers/state/theme_provider.dart';

class Toolbar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final bool showActions;

  const Toolbar({
    super.key,
    required this.title,
    this.height = 56.0, // Default height for AppBar
    this.showActions = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    final List<Widget> actions = !showActions
        ? []
        : [
            IconButton(
              icon: const Icon(Icons.bug_report), // Heart icon for favorites
              tooltip: 'Debug',
              onPressed: () {
                Application.router.navigateTo(context, '/debug');
              },
            ),
            IconButton(
              icon: themeMode == ThemeMode.system
                  ? const Icon(Icons.auto_mode)
                  : themeMode == ThemeMode.light
                      ? const Icon(Icons.light_mode)
                      : const Icon(Icons.dark_mode),
              tooltip: 'Debug',
              onPressed: themeNotifier.cycleNextTheme,
            ),
            IconButton(
              icon: const Icon(Icons.favorite), // Heart icon for favorites
              tooltip: 'Favorites',
              onPressed: () {
                Application.router.navigateTo(context, '/currencies');
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings), // Settings icon
              tooltip: 'Settings',
              onPressed: () {
                // Handle settings action
                print('Settings pressed');
                Application.router.navigateTo(context, '/settings');
              },
            ),
          ];

    return AppBar(
      title: Text(title),
      actions: actions,
    );
  }
}
