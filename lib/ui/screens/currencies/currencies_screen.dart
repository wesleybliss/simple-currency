import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/constants/constants.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/ui/screens/currencies/currencies_error.dart';
import 'package:simple_currency/ui/screens/currencies/currencies_loading.dart';
import 'package:simple_currency/ui/screens/currencies/currencies_ready.dart';
import 'package:simple_currency/ui/widgets/toolbar.dart';

class CurrenciesScreen extends ConsumerStatefulWidget {
  const CurrenciesScreen({super.key});
  @override
  ConsumerState<CurrenciesScreen> createState() => _CurrenciesScreenState();
}

class _CurrenciesScreenState extends ConsumerState<CurrenciesScreen> {

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(currenciesProvider);

    return Scaffold(
      appBar: Toolbar(title: Constants.strings.appName),
      body: state.loading
          ? const CurrenciesLoading()
          : state.error != null
          ? const CurrenciesError()
          : const CurrenciesReady(),
    );
  }
}
