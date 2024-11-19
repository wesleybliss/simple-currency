import 'package:simple_currency/domain/io/net/dio_client.dart';
import 'package:simple_currency/domain/models/currency_response.dart';
import 'package:simple_currency/utils/logger.dart';

class CurrenciesRepo {
  
  CurrenciesRepo(this.dio);
  
  final log = Logger('CurrenciesRepo');
  final DioClient dio;
  
  Future<CurrencyResponse?> fetchCurrencies() async {
    log.d('getCurrencies');
    
    final res = await dio.get('/currencies');
    final data = res.data == null ? null : CurrencyResponse.fromJson(res.data);
    
    log.d('CurrenciesNotifier response: got ${data?.data.currencies.length ?? 0} currencies');
    
    return data;
  }
  
}
