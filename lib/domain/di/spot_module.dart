import 'package:dio/dio.dart';
import 'package:simple_currency/domain/di/spot.dart';
import 'package:simple_currency/domain/io/net/dio_client.dart';
import 'package:simple_currency/domain/io/net/i_dio_client.dart';
import 'package:simple_currency/domain/io/repos/currencies_repo.dart';
import 'package:simple_currency/domain/io/repos/i_currencies_repo.dart';

abstract class SpotModule {
  static void registerDependencies() {
    Spot.init((factory, single) {
      
      // Globals
      // single<ISettings, Settings>((get) => Settings());

      // Networking
      single<Dio, Dio>((get) => Dio());
      single<IDioClient, IDioClient>((get) => DioClient());
      
      // DAOs
      // single<AUserDao, AUserDao>((get) => UserDao());
      
      // Repositories
      single<ICurrenciesRepo, ICurrenciesRepo>((get) => CurrenciesRepo(get<IDioClient>()));

      // Core Services
      // factory<IAuthService, AuthService>((get) => AuthService());

    });
  }
}
