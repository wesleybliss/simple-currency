import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/ui/widgets/currencies_list.dart';
import 'package:simple_currency/utils/logger.dart';

class CurrenciesReady extends ConsumerWidget {
  const CurrenciesReady({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final log = Logger('CurrenciesReady');
    final state = ref.watch(currenciesProvider);

    return Column(children: [
      Text('todo currencies'),
      Expanded(
        child: CurrenciesList(currencies: state.currencies ?? []),
      )]);
  }
}
