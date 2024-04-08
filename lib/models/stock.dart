import 'dart:convert';

class Stock {
  final int key;
  final String symbol;
  final String company;
  final String industry;
  final String sectoralIndex;
  Stock({
    required this.key,
    required this.symbol,
    required this.company,
    required this.industry,
    required this.sectoralIndex,
  });

  Stock copyWith({
    int? key,
    String? symbol,
    String? company,
    String? industry,
    String? sectoralIndex,
  }) {
    return Stock(
      key: key ?? this.key,
      symbol: symbol ?? this.symbol,
      company: company ?? this.company,
      industry: industry ?? this.industry,
      sectoralIndex: sectoralIndex ?? this.sectoralIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key,
      'symbol': symbol,
      'company': company,
      'industry': industry,
      'sectoralIndex': sectoralIndex,
    };
  }

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      key: map['key'] as int,
      symbol: map['symbol'] as String,
      company: map['company'] as String,
      industry: map['industry'] as String,
      sectoralIndex: map['sectoralIndex'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Stock.fromJson(String source) =>
      Stock.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Stock(key: $key, symbol: $symbol, company: $company, industry: $industry, sectoralIndex: $sectoralIndex)';
  }

  @override
  bool operator ==(covariant Stock other) {
    if (identical(this, other)) return true;

    return other.key == key &&
        other.symbol == symbol &&
        other.company == company &&
        other.industry == industry &&
        other.sectoralIndex == sectoralIndex;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        symbol.hashCode ^
        company.hashCode ^
        industry.hashCode ^
        sectoralIndex.hashCode;
  }
}
