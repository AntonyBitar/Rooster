import '../ComboItem/ComboItemModel.dart';
import '../Company/CompanyModel.dart';
import '../Currency/CurrencyModel.dart';

class Combo {
  int? id;
  Company? company;
  int? companyId;
  String? name;
  String? code;
  String? description;
  double? total;
  double? price;
  bool? active;
  Currency? currency;
  int? currencyId;
  String? brand;
  String? imgPath;
  List<ComboItem>? comboItems;

  Combo({
    this.id,
    this.company,
    this.companyId,
    this.name,
    this.code,
    this.description,
    this.total,
    this.price,
    this.active,
    this.currency,
    this.currencyId,
    this.brand,
    this.imgPath,
    this.comboItems,
  });

  factory Combo.fromJson(Map<String, dynamic> json) {
    return Combo(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      companyId: json['company_id'],
      name: json['name'],
      code: json['code'],
      description: json['description'],
      total: json['total']?.toDouble(),
      price: json['price']?.toDouble(),
      active: json['active'],
      currency: json['currency'] != null ? Currency.fromJson(json['currency']) : null,
      currencyId: json['currency_id'],
      brand: json['brand'],
      imgPath: json['img_path'],
      comboItems: json['comboItems'] != null
          ? List<ComboItem>.from(json['comboItems'].map((x) => ComboItem.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'company_id': companyId,
      'name': name,
      'code': code,
      'description': description,
      'total': total,
      'price': price,
      'active': active,
      'currency': currency?.toJson(),
      'currency_id': currencyId,
      'brand': brand,
      'img_path': imgPath,
      'comboItems': comboItems?.map((x) => x.toJson()).toList(),
    };
  }
}
