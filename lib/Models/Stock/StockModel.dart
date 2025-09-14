import '../Item/ItemModel.dart';
import '../WareHouse/WareHouseModel.dart';

class Stock {
  int? id;
  Warehouse? warehouse;
  Item? item;
  double? qtyOnHand;
  double? qtyReplenished;
  double? qtyTransferred;
  double? qtySold;
  int? qtyOnHandPackageId;
  int? qtyReplenishedPackageId;
  int? qtyTransferredPackageId;
  int? qtySoldPackageId;
  double? initQty;

  Stock({
    this.id,
    this.warehouse,
    this.item,
    this.qtyOnHand,
    this.qtyReplenished,
    this.qtyTransferred,
    this.qtySold,
    this.qtyOnHandPackageId,
    this.qtyReplenishedPackageId,
    this.qtyTransferredPackageId,
    this.qtySoldPackageId,
    this.initQty,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'],
      warehouse: json['warehouse'] != null ? Warehouse.fromJson(json['warehouse']) : null,
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      qtyOnHand: json['qty_on_hand'] != null ? double.tryParse(json['qty_on_hand'].toString()) : null,
      qtyReplenished: json['qty_replenished'] != null ? double.tryParse(json['qty_replenished'].toString()) : null,
      qtyTransferred: json['qty_transferred'] != null ? double.tryParse(json['qty_transferred'].toString()) : null,
      qtySold: json['qty_sold'] != null ? double.tryParse(json['qty_sold'].toString()) : null,
      qtyOnHandPackageId: json['qty_on_hand_package_id'],
      qtyReplenishedPackageId: json['qty_replenished_package_id'],
      qtyTransferredPackageId: json['qty_transferred_package_id'],
      qtySoldPackageId: json['qty_sold_package_id'],
      initQty: json['init_qty'] != null ? double.tryParse(json['init_qty'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'warehouse': warehouse?.toJson(),
      'item': item?.toJson(),
      'qty_on_hand': qtyOnHand,
      'qty_replenished': qtyReplenished,
      'qty_transferred': qtyTransferred,
      'qty_sold': qtySold,
      'qty_on_hand_package_id': qtyOnHandPackageId,
      'qty_replenished_package_id': qtyReplenishedPackageId,
      'qty_transferred_package_id': qtyTransferredPackageId,
      'qty_sold_package_id': qtySoldPackageId,
      'init_qty': initQty,
    };
  }
}
