
import 'package:flutter/material.dart';
import 'package:simple_currency/domain/models/currency.dart';

class CurrencyInputsList extends StatelessWidget {
  const CurrencyInputsList({super.key, required List<Currency> this.currencies});

  final List<Currency> currencies;
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: currencies?.length ?? 0,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(currencies![index].symbol),
          subtitle: Text(currencies![index].name),
        );
      },
    );
  }
}
