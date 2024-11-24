import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeLoading extends ConsumerWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text('FETCHING CURRENCIES', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
        ]));
  }
}
