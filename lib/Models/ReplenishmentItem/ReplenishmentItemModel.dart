import '../Item/ItemModel.dart';
import '../Package/PackageModel.dart';
import '../Replenishment/ReplenishmentModel.dart';

class ReplenishmentItem {
  int? id;
  Item? item;
  Replenishment? replenishment;
  double? inStockQty;
  Package? inStockQtyPackage;
  double? replenishedQty;
  Package? replenishedQtyPackage;
  String? note;
  double? unitCost;

  ReplenishmentItem({
    this.id,
    this.item,
    this.replenishment,
    this.inStockQty,
    this.inStockQtyPackage,
    this.replenishedQty,
    this.replenishedQtyPackage,
    this.note,
    this.unitCost,
  });

  String get itemName => item?.itemName ?? '';

  factory ReplenishmentItem.fromJson(Map<String, dynamic> json) {
    return ReplenishmentItem(
      id: json['id'],
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      replenishment: json['replenishment'] != null ? Replenishment.fromJson(json['replenishment']) : null,
      inStockQty: json['in_stock_qty'] != null ? double.tryParse(json['in_stock_qty'].toString()) : null,
      inStockQtyPackage: json['in_stock_qty_package'] != null ? Package.fromJson(json['in_stock_qty_package']) : null,
      replenishedQty: json['replenished_qty'] != null ? double.tryParse(json['replenished_qty'].toString()) : null,
      replenishedQtyPackage: json['replenished_qty_package'] != null ? Package.fromJson(json['replenished_qty_package']) : null,
      note: json['note'],
      unitCost: json['unit_cost'] != null ? double.tryParse(json['unit_cost'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item?.toJson(),
      'replenishment': replenishment?.toJson(),
      'in_stock_qty': inStockQty,
      'in_stock_qty_package': inStockQtyPackage?.toJson(),
      'replenished_qty': replenishedQty,
      'replenished_qty_package': replenishedQtyPackage?.toJson(),
      'note': note,
      'unit_cost': unitCost,
    };
  }
}
