import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/utils/utils.dart';

class HomeLoading extends ConsumerWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger the fetch on build
    Utils.nextTick(() {
      // ref.read(currenciesProvider.notifier).fetchCurrencies();
      ref.read(currenciesProvider.notifier).readCurrencies();
    });

    return const Center(child: CircularProgressIndicator());
  }
}
