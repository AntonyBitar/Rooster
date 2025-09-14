import '../Company/CompanyModel.dart';

class Currency {
  int? id;
  Company? company;
  String? name;
  String? symbol;
  bool? active;
  double? latestRate;

  Currency({
    this.id,
    this.company,
    this.name,
    this.symbol,
    this.active,
    this.latestRate,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      name: json['name'],
      symbol: json['symbol'],
      active: json['active'],
      latestRate: (json['latest_rate'] != null) ? double.tryParse(json['latest_rate'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'name': name,
      'symbol': symbol,
      'active': active,
      'latest_rate': latestRate,
    };
  }
}
