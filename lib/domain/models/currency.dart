
class Currency {
  // final int id;
  final String symbol;
  final String name;
  final double rate;
  final bool selected;

  Currency({
    // required this.id,
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
      selected: false,
    );
  }
}
