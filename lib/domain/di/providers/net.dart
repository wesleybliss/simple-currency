import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/io/net/dio_client.dart';
import 'package:simple_currency/domain/io/repos/currencies_repo.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final currenciesRepoProvider = Provider<CurrenciesRepo>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CurrenciesRepo(dioClient);
});
