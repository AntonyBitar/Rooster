import '../Company/CompanyModel.dart';
import '../Item/ItemModel.dart';

class AlternativeCode {
  int? id;
  String? code;
  String? printCode;
  Company? company;
  Item? item;

  AlternativeCode({this.id, this.code, this.printCode, this.company, this.item});

  factory AlternativeCode.fromJson(Map<String, dynamic> json) {
    return AlternativeCode(
      id: json['id'],
      code: json['code'],
      printCode: json['print_code'],
      company:
      json['company'] != null ? Company.fromJson(json['company']) : null,
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'print_code': printCode,
      'company': company?.toJson(),
      'item': item?.toJson(),
    };
  }
}
