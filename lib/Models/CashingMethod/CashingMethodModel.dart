import '../Company/CompanyModel.dart';
import '../Order/OrderModel.dart';

class CashingMethod {
  int? id;
  String? title;
  bool? active;
  Company? company;
  String? image;

  List<Order>? orders;

  CashingMethod({this.id, this.title, this.active, this.company, this.image, this.orders});

  factory CashingMethod.fromJson(Map<String, dynamic> json) {
    return CashingMethod(
      id: json['id'],
      title: json['title'],
      active: json['active'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      image: json['image'],
      orders: json['orders'] != null
          ? List<Order>.from(json['orders'].map((x) => Order.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'active': active,
      'company': company?.toJson(),
      'image': image,
      'orders': orders?.map((x) => x.toJson()).toList(),
    };
  }
}
