import 'package:flutter/material.dart';
import 'package:simple_currency/config/application.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  
  const Toolbar({
    super.key,
    required this.title,
    this.height = 56.0, // Default height for AppBar
  });

  @override
  Size get preferredSize => Size.fromHeight(height);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.bug_report), // Heart icon for favorites
          tooltip: 'Debug',
          onPressed: () {
            Application.router.navigateTo(context, '/debug');
          },
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
      ],
    );
  }
}
