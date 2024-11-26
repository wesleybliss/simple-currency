
import 'package:simple_currency/domain/di/spot.dart';
import 'package:simple_currency/domain/io/i_settings.dart';
import 'package:simple_currency/domain/models/currency.dart';

/// Converts the input value to the currency of the symbol, using USD as the base.
/// Returns a map of symbol to converted value.
Map<String, double> convertCurrencies(String symbol, double inputValue, List<Currency> currencies) {
  // Find the currency that was changed
  final Currency changedCurrency = currencies.firstWhere((it) => it.symbol == symbol);
  
  // Convert the input value to USD
  final double valueInUSD = symbol == 'USD' ? inputValue : inputValue / changedCurrency.rate;
  
  // Create a map of symbol to converted value
  final Map<String, double> updatedValues = {};
  
  for (var currency in currencies) {
    if (currency.symbol == symbol) {
      updatedValues[currency.symbol] = inputValue;
    } else {
      final settings = spot<ISettings>();
      final int decimals = settings.roundingDecimals;
      final double convertedValue = valueInUSD * currency.rate;
      final double roundedValue = double.parse(convertedValue.toStringAsFixed(decimals));
      updatedValues[currency.symbol] = convertedValue;
    }
  }

  return updatedValues;
}
