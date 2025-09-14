import '../Company/CompanyModel.dart';

class PaymentTerm {
  int? id;
  Company? company;
  String? title;
  bool? active;

  PaymentTerm({this.id, this.company, this.title, this.active});

  factory PaymentTerm.fromJson(Map<String, dynamic> json) {
    return PaymentTerm(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      title: json['title'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'title': title,
      'active': active,
    };
  }
}
