import 'package:simple_currency/domain/io/net/dio_client.dart';
import 'package:simple_currency/domain/io/repos/i_currencies_repo.dart';
import 'package:simple_currency/domain/models/currency_response.dart';
import 'package:simple_currency/utils/logger.dart';

class CurrenciesRepo implements ICurrenciesRepo {
  
  CurrenciesRepo(this.dio);
  
  @override
  final log = Logger('CurrenciesRepo');
  
  @override
  final DioClient dio;

  @override
  Future<CurrencyResponse?> fetchCurrencies() async {
    log.d('getCurrencies');
    
    final res = await dio.get('/currencies');
    final data = res.data == null ? null : CurrencyResponse.fromJson(res.data);
    
    log.d('CurrenciesNotifier response: got ${data?.data.currencies.length ?? 0} currencies');
    
    return data;
  }
  
}
