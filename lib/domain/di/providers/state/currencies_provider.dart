import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/di/spot.dart';
import 'package:simple_currency/domain/io/repos/i_currencies_repo.dart';
import 'package:simple_currency/domain/models/currency.dart';
import 'package:simple_currency/domain/models/currency_response.dart';
import 'package:simple_currency/store/SimpleCurrencyStore.dart';
import 'package:simple_currency/utils/logger.dart';

class CurrenciesState {
  final List<Currency>? currencies;
  final bool loading;
  final String? error;

  CurrenciesState({this.currencies, this.loading = false, this.error});
}

class CurrenciesNotifier extends StateNotifier<CurrenciesState> {
  final log = Logger('CurrenciesNotifier');
  final currencyBox = store.box<Currency>();
  final ICurrenciesRepo currenciesRepo;

  CurrenciesNotifier(this.currenciesRepo) : super(CurrenciesState());

  List<Currency> get selectedCurrencies {
    return state.currencies?.where((currency) => currency.selected).toList() ?? [];
  }
  
  void setCurrency(Currency currency) {
    final next = (state.currencies ?? []).map((e) => e.id == currency.id ? currency : e).toList();
    state = CurrenciesState(currencies: next, loading: false);
  }
  
  Future<void> readCurrencies({ bool showLoading = true }) async {
    if (showLoading) {
      state = CurrenciesState(loading: true);
    }
    
    final items = await currencyBox.getAllAsync();
    
    state = CurrenciesState(currencies: items ?? [], loading: false);
    
    log.d('readCurrencies: ${items.map((e) => '${e.symbol}: (${e.selected})').join(', ')}');
    
  }
  
  Future<void> fetchCurrencies() async {
    state = CurrenciesState(loading: true);
    
    try {
      final CurrencyResponse? res = await currenciesRepo.fetchCurrencies();
      await currencyBox.putManyAsync(res?.data.currencies ?? []);
      
      state = CurrenciesState(currencies: res?.data.currencies ?? [], loading: false);
    } catch (e) {
      log.e('CurrenciesNotifier error', e);
      state = CurrenciesState(loading: false, error: e.toString());
    }
  }
  
}

final currenciesProvider = StateNotifierProvider<CurrenciesNotifier, CurrenciesState>((ref) {
  final currenciesRepo = spot<ICurrenciesRepo>();
  return CurrenciesNotifier(currenciesRepo);
});
