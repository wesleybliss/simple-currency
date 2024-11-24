import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_currency/domain/constants/constants.dart';
import 'package:simple_currency/domain/di/spot.dart';
import 'package:simple_currency/domain/io/repos/i_currencies_repo.dart';
import 'package:simple_currency/domain/models/currency.dart';
import 'package:simple_currency/domain/models/currency_response.dart';
import 'package:simple_currency/objectbox.g.dart';
import 'package:simple_currency/store/SimpleCurrencyStore.dart';
import 'package:simple_currency/utils/logger.dart';

class CurrenciesState {
  final List<Currency> currencies;
  final bool loading;
  final String? error;

  CurrenciesState({
    List<Currency>? currencies,
    this.loading = false,
    this.error,
  }) : currencies = currencies ?? List.empty();
}

class CurrenciesNotifier extends StateNotifier<CurrenciesState> {
  final log = Logger('CurrenciesNotifier');
  final currencyBox = store.box<Currency>();
  final ICurrenciesRepo currenciesRepo;

  CurrenciesNotifier(this.currenciesRepo) : super(CurrenciesState());

  void setCurrency(Currency currency) {
    final next = state.currencies.map((e) => e.id == currency.id ? currency : e).toList();
    state = CurrenciesState(currencies: next);
    currencyBox.put(currency);
  }
  
  Future<List<Currency>> readCurrencies({ bool showLoading = true }) async {
    
    if (showLoading) {
      state = CurrenciesState(loading: true);
    }
    
    // final items = await currencyBox.getAllAsync();
    final items = await currencyBox.query().order(Currency_.order).build().findAsync();
    
    state = CurrenciesState(currencies: items, loading: false);
    
    // log.d('readCurrencies:\n${items.map((e) => '${e.symbol}: (${e.selected})').join('\n')}');
    log.d('readCurrencies: ${items.length}');
    
    return items;
    
  }

  Future<void> clearCurrencies() async {
    await currencyBox.removeAllAsync();
    state = CurrenciesState(currencies: [], loading: false);
  }
  
  Future<void> fetchCurrencies() async {
    state = CurrenciesState(loading: true);
    
    try {
      final CurrencyResponse? res = await currenciesRepo.fetchCurrencies();
      
      final data = res?.data.currencies ?? [];
      final prev = await currencyBox.getAllAsync();
      
      // Update currencies without destroying locally saved data, like selected state
      store.runInTransaction(TxMode.write, () {
        for (var i = 0; i < data.length; i++) {
          final it = data[i];
          final existing = prev.firstWhereOrNull((e) => e.symbol == it.symbol);
          
          if (existing != null) {
            // log.d('DEBUG: Updating currency: ${it.symbol} (selected: ${existing.selected})');
            data[i] = it.copyWith(selected: existing.selected);
          }
          
          currencyBox.put(it);
        }
      });
      
      state = CurrenciesState(currencies: data, loading: false);
    } catch (e) {
      log.e('CurrenciesNotifier error', e);
      state = CurrenciesState(loading: false, error: e.toString());
    }
  }
  
  Future<void> initializeCurrencies() async {

    final prefs = await SharedPreferences.getInstance();
    final lastUpdatedValue = prefs.getString(Constants.keys.settings.lastUpdated);
    final lastUpdated = lastUpdatedValue != null ? DateTime.parse(lastUpdatedValue) : null;
    final shouldUpdate = lastUpdated == null || DateTime.now().difference(lastUpdated).inHours > 6;
    final savedCurrencies = await readCurrencies();
    
    // If we haven't fetched in more than 6 hours, fetch again
    if (savedCurrencies.isEmpty || shouldUpdate) {
      log.d('Initializing currencies. Either no currencies saved, or more than 6 hours since last update');
      await fetchCurrencies();
      
      prefs.setString(Constants.keys.settings.lastUpdated, DateTime.now().toIso8601String());
    }
    
  }
  
}

final currenciesProvider = StateNotifierProvider<CurrenciesNotifier, CurrenciesState>((ref) {
  final currenciesRepo = spot<ICurrenciesRepo>();
  return CurrenciesNotifier(currenciesRepo);
});

final selectedCurrenciesProvider = Provider<List<Currency>>((ref) {
  // Watch the state from the currenciesProvider
  final currenciesState = ref.watch(currenciesProvider);
  // Derive the selected currencies
  return currenciesState.currencies.where((currency) => currency.selected).toList();
});
