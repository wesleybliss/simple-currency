import 'package:dio/dio.dart';
import 'package:simple_currency/domain/constants/constants.dart';
import 'package:simple_currency/utils/logger.dart';

class DioClient {
  final log = Logger('DioClient');
  final Dio _dio;

  DioClient() : _dio = Dio(BaseOptions(
    baseUrl: Constants.strings.baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  )) {
    _dio.interceptors.add(LogInterceptor(responseBody: true)); // Optional logging
  }

  Future<Response<dynamic>> fetchCurrencies() async {
    log.d('getCurrencies');
    return await _dio.get('/currencies');
  }
  
  Future<Response> get(String path) async {
    log.d('GET $path');
    
    final res = await _dio.get(path);
    
    if (res.statusCode != 200) {
      log.e('GET $path failed with status code ${res.statusCode}');
      throw DioError(requestOptions: res.requestOptions, error: 'GET $path failed with status code ${res.statusCode}');
    }
    
    return res;
  }

// Add more methods for POST, PUT, DELETE as needed
}
