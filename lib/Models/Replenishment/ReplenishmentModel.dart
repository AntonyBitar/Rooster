import '../Currency/CurrencyModel.dart';
import '../ReplenishmentItem/ReplenishmentItemModel.dart';
import '../WareHouse/WareHouseModel.dart';

class Replenishment {
  int? id;
  Warehouse? destWarehouse;
  String? replenishmentNumber;
  String? reference;
  double? totalQuantity;
  DateTime? date;
  String? note;
  int? companyId;
  int? userId;
  String? status;
  Currency? replenishmentCurrency;
  List<ReplenishmentItem>? items;

  Replenishment({
    this.id,
    this.destWarehouse,
    this.replenishmentNumber,
    this.reference,
    this.totalQuantity,
    this.date,
    this.note,
    this.companyId,
    this.userId,
    this.status,
    this.replenishmentCurrency,
    this.items,
  });

  factory Replenishment.fromJson(Map<String, dynamic> json) {
    return Replenishment(
      id: json['id'],
      destWarehouse: json['dest_warehouse'] != null ? Warehouse.fromJson(json['dest_warehouse']) : null,
      replenishmentNumber: json['replenishment_number'],
      reference: json['reference'],
      totalQuantity: json['total_quantity'] != null ? double.tryParse(json['total_quantity'].toString()) : null,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      note: json['note'],
      companyId: json['company_id'],
      userId: json['user_id'],
      status: json['status'],
      replenishmentCurrency: json['replenishment_currency'] != null ? Currency.fromJson(json['replenishment_currency']) : null,
      items: json['items'] != null
          ? List<ReplenishmentItem>.from(json['items'].map((x) => ReplenishmentItem.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dest_warehouse': destWarehouse?.toJson(),
      'replenishment_number': replenishmentNumber,
      'reference': reference,
      'total_quantity': totalQuantity,
      'date': date?.toIso8601String(),
      'note': note,
      'company_id': companyId,
      'user_id': userId,
      'status': status,
      'replenishment_currency': replenishmentCurrency?.toJson(),
      'items': items?.map((x) => x.toJson()).toList(),
    };
  }
}
