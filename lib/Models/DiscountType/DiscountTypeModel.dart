import '../Company/CompanyModel.dart';
import '../Order/OrderModel.dart';

class DiscountType {
  int? id;
  Company? company;
  String? type;
  double? discountValue;

  DiscountType({this.id, this.company, this.type, this.discountValue});

  double get floatDiscountValue => discountValue ?? 0.0;

  List<Order>? orders;

  factory DiscountType.fromJson(Map<String, dynamic> json) {
    return DiscountType(
      id: json['id'],
      type: json['type'],
      discountValue: (json['discount_value'] != null)
          ? double.tryParse(json['discount_value'].toString())
          : null,
      company:
      json['company'] != null ? Company.fromJson(json['company']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'discount_value': discountValue,
      'company': company?.toJson(),
      'orders': orders?.map((x) => x.toJson()).toList(),
    };
  }
}
