
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:objectbox/objectbox.dart';
import 'package:simple_currency/domain/models/model.dart';

part 'currency.g.dart';

@Entity()
@CopyWith()
class Currency extends Model {
  @Id()
  @override
  int id = 0;
  final String symbol;
  final String name;
  final double rate;
  final bool selected;

  Currency({
    this.id = 0,
    required this.symbol,
    required this.name,
    required this.rate,
    required this.selected,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      // id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      rate: (json['rate'] as num).toDouble(),
      selected: json['symbol'] == 'AFN',
    );
  }
}
