import '../Item/ItemModel.dart';
import '../Package/PackageModel.dart';
import '../Transfer/TransferModel.dart';

class TransferItem {
  int? id;
  Item? item;
  Transfer? transfer;
  double? transferredQty;
  Package? transferredQtyPackage;
  double? receivedQty;
  Package? receivedQtyPackage;
  double? qtyDifference;
  Package? qtyDifferencePackage;
  String? note;

  TransferItem({
    this.id,
    this.item,
    this.transfer,
    this.transferredQty,
    this.transferredQtyPackage,
    this.receivedQty,
    this.receivedQtyPackage,
    this.qtyDifference,
    this.qtyDifferencePackage,
    this.note,
  });

  factory TransferItem.fromJson(Map<String, dynamic> json) {
    return TransferItem(
      id: json['id'],
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      transfer: json['transfer'] != null ? Transfer.fromJson(json['transfer']) : null,
      transferredQty: json['transferred_qty'] != null ? double.tryParse(json['transferred_qty'].toString()) : null,
      transferredQtyPackage: json['transferred_qty_package'] != null ? Package.fromJson(json['transferred_qty_package']) : null,
      receivedQty: json['received_qty'] != null ? double.tryParse(json['received_qty'].toString()) : null,
      receivedQtyPackage: json['received_qty_package'] != null ? Package.fromJson(json['received_qty_package']) : null,
      qtyDifference: json['qty_difference'] != null ? double.tryParse(json['qty_difference'].toString()) : null,
      qtyDifferencePackage: json['qty_difference_package'] != null ? Package.fromJson(json['qty_difference_package']) : null,
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item?.toJson(),
      'transfer': transfer?.toJson(),
      'transferred_qty': transferredQty,
      'transferred_qty_package': transferredQtyPackage?.toJson(),
      'received_qty': receivedQty,
      'received_qty_package': receivedQtyPackage?.toJson(),
      'qty_difference': qtyDifference,
      'qty_difference_package': qtyDifferencePackage?.toJson(),
      'note': note,
    };
  }
}
