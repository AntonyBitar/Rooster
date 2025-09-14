
import '../Company/CompanyModel.dart';
import '../Currency/CurrencyModel.dart';

class Pricelist {
  int? id;
  Company? company;
  String? title;
  bool? active;
  String? code;
  bool? vatInclusivePrices;
  bool? pricesDerivedFromAnotherPricelist;
  Pricelist? derivedFromList;
  int? adjustmentPercentage;
  Currency? convertToCurrency;
  String? roundingMethod;
  double? roundingPrecision;
  String? transactionDisplayMode;

  Pricelist({
    this.id,
    this.company,
    this.title,
    this.active,
    this.code,
    this.vatInclusivePrices,
    this.pricesDerivedFromAnotherPricelist,
    this.derivedFromList,
    this.adjustmentPercentage,
    this.convertToCurrency,
    this.roundingMethod,
    this.roundingPrecision,
    this.transactionDisplayMode,
  });

  factory Pricelist.fromJson(Map<String, dynamic> json) {
    return Pricelist(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      title: json['title'],
      active: json['active'],
      code: json['code'],
      vatInclusivePrices: json['vat_inclusive_prices'],
      pricesDerivedFromAnotherPricelist: json['prices_derived_from_another_pricelist'],
      derivedFromList: json['derived_from_list'] != null ? Pricelist.fromJson(json['derived_from_list']) : null,
      adjustmentPercentage: json['adjustment_percentage'],
      convertToCurrency: json['convert_to_currency'] != null ? Currency.fromJson(json['convert_to_currency']) : null,
      roundingMethod: json['rounding_method'],
      roundingPrecision: (json['rounding_precision'] != null) ? double.tryParse(json['rounding_precision'].toString()) : null,
      transactionDisplayMode: json['transaction_display_mode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'title': title,
      'active': active,
      'code': code,
      'vat_inclusive_prices': vatInclusivePrices,
      'prices_derived_from_another_pricelist': pricesDerivedFromAnotherPricelist,
      'derived_from_list': derivedFromList?.toJson(),
      'adjustment_percentage': adjustmentPercentage,
      'convert_to_currency': convertToCurrency?.toJson(),
      'rounding_method': roundingMethod,
      'rounding_precision': roundingPrecision,
      'transaction_display_mode': transactionDisplayMode,
    };
  }
}
