import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';

class HomeError extends ConsumerWidget {
  const HomeError({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(currenciesProvider);

    void onFetchCurrenciesClick() {
      ref.read(currenciesProvider.notifier).fetchCurrencies();
    }

    return Center(
        child: Column(children: [
      Text('Error: ${state.error}'),
      ElevatedButton(
        onPressed: onFetchCurrenciesClick,
        child: const Text('Fetch Currencies'),
      ),
    ]));
  }
}
