import 'package:flutter/foundation.dart';
import 'package:simple_currency/domain/io/net/i_dio_client.dart';
import 'package:simple_currency/domain/models/currency_response.dart';
import 'package:simple_currency/utils/logger.dart';

abstract class ICurrenciesRepo {
  
  @protected
  abstract final Logger log;

  @protected
  abstract final IDioClient dio;
  
  Future<CurrencyResponse?> fetchCurrencies();
  
}
