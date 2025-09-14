import '../Company/CompanyModel.dart';
import '../Item/ItemModel.dart';
class SupplierCode {
  int? id;
  String? code;
  String? printCode;
  Company? company;
  Item? item;

  SupplierCode({this.id, this.code, this.printCode, this.company, this.item});

  factory SupplierCode.fromJson(Map<String, dynamic> json) {
    return SupplierCode(
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
