
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/domain/models/currency.dart';
import 'package:simple_currency/store/SimpleCurrencyStore.dart';
import 'package:simple_currency/utils/logger.dart';

class CurrenciesList extends ConsumerWidget {
  const CurrenciesList({super.key, required this.currencies});

  final List<Currency> currencies;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: currencies.length ?? 0,
      itemBuilder: (context, index) {
        final log = Logger('CurrenciesList');
        final item = currencies[index];
        
        return ListTile(
          title: Text(item.symbol),
          subtitle: Text(item.name),
          trailing: IconButton(
            icon: item.selected ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border_outlined),
            onPressed: () async {
              
              final box = store.box<Currency>();
              final next = item.copyWith(selected: !item.selected);
              
              // Update observable state
              ref.read(currenciesProvider.notifier).setCurrency(next);
              
              // Update saved data
              await box.putAsync(next);
            },
          ),
        );
      },
    );
  }
}
