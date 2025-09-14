
import '../Company/CompanyModel.dart';
import '../Currency/CurrencyModel.dart';
import '../Item/ItemModel.dart';
import '../User/UserModel.dart';

class PriceChange {
  int? id;
  Company? company;
  User? user;
  Currency? currency;
  Item? item;
  DateTime? startDate;
  double? oldPrice;
  double? updatedPrice;
  DateTime? appliedAt;

  PriceChange({
    this.id,
    this.company,
    this.user,
    this.currency,
    this.item,
    this.startDate,
    this.oldPrice,
    this.updatedPrice,
    this.appliedAt,
  });

  factory PriceChange.fromJson(Map<String, dynamic> json) {
    return PriceChange(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      currency: json['currency'] != null ? Currency.fromJson(json['currency']) : null,
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
      oldPrice: json['old_price'] != null ? double.tryParse(json['old_price'].toString()) : null,
      updatedPrice: json['updated_price'] != null ? double.tryParse(json['updated_price'].toString()) : null,
      appliedAt: json['applied_at'] != null ? DateTime.parse(json['applied_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'user': user?.toJson(),
      'currency': currency?.toJson(),
      'item': item?.toJson(),
      'start_date': startDate?.toIso8601String(),
      'old_price': oldPrice,
      'updated_price': updatedPrice,
      'applied_at': appliedAt?.toIso8601String(),
    };
  }
}
