import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/di/providers/net.dart';
import 'package:simple_currency/domain/io/repos/currencies_repo.dart';
import 'package:simple_currency/domain/models/currency.dart';
import 'package:simple_currency/domain/models/currency_response.dart';
import 'package:simple_currency/utils/logger.dart';

class CurrenciesState {
  final List<Currency>? currencies;
  final bool loading;
  final String? error;

  CurrenciesState({this.currencies, this.loading = false, this.error});
}

class CurrenciesNotifier extends StateNotifier<CurrenciesState> {
  final log = Logger('CurrenciesNotifier');
  final CurrenciesRepo currenciesRepo;

  CurrenciesNotifier(this.currenciesRepo) : super(CurrenciesState());

  Future<void> fetchCurrencies() async {
    state = CurrenciesState(loading: true);
    
    try {
      final CurrencyResponse? res = await currenciesRepo.fetchCurrencies();
      state = CurrenciesState(currencies: res?.data.currencies ?? [], loading: false);
    } catch (e) {
      log.e('CurrenciesNotifier error', e);
      state = CurrenciesState(loading: false, error: e.toString());
    }
  }
}

final currenciesProvider = StateNotifierProvider<CurrenciesNotifier, CurrenciesState>((ref) {
  final currenciesRepo = ref.watch(currenciesRepoProvider);
  return CurrenciesNotifier(currenciesRepo);
});
