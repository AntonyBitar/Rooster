
import '../Item/ItemModel.dart';
import '../LigneType/LigneTypeModel.dart';
import '../SalesOrder/SalesOrderModel.dart';
import '../Combo/ComboModel.dart';

class OrderLineSalesOrder {
  int? id;
  SalesOrder? salesOrder;
  int? salesOrderId;
  LineType? lineType;
  int? lineTypeId;
  Item? item;
  int? itemId;
  Combo? combo;
  int? comboId;
  String? title;
  String? itemDescription;
  String? itemMainCode;
  double? itemQuantity;
  int? itemWarehouseId;
  double? itemUnitPrice;
  double? itemDiscount;
  double? itemTotal;
  String? comboDescription;
  double? comboQuantity;
  int? comboWarehouseId;
  double? comboUnitPrice;
  double? comboDiscount;
  double? comboTotal;
  String? note;
  String? image;
  int? orderIndex;
  String? comboCode;
  String? itemName;

  OrderLineSalesOrder({
    this.id,
    this.salesOrder,
    this.salesOrderId,
    this.lineType,
    this.lineTypeId,
    this.item,
    this.itemId,
    this.combo,
    this.comboId,
    this.title,
    this.itemDescription,
    this.itemMainCode,
    this.itemQuantity,
    this.itemWarehouseId,
    this.itemUnitPrice,
    this.itemDiscount,
    this.itemTotal,
    this.comboDescription,
    this.comboQuantity,
    this.comboWarehouseId,
    this.comboUnitPrice,
    this.comboDiscount,
    this.comboTotal,
    this.note,
    this.image,
    this.orderIndex,
    this.comboCode,
    this.itemName,
  });

  factory OrderLineSalesOrder.fromJson(Map<String, dynamic> json) {
    return OrderLineSalesOrder(
      id: json['id'],
      salesOrder: json['salesOrder'] != null ? SalesOrder.fromJson(json['salesOrder']) : null,
      salesOrderId: json['sales_order_id'],
      lineType: json['lineType'] != null ? LineType.fromJson(json['lineType']) : null,
      lineTypeId: json['line_type_id'],
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      itemId: json['item_id'],
      combo: json['combo'] != null ? Combo.fromJson(json['combo']) : null,
      comboId: json['combo_id'],
      title: json['title'],
      itemDescription: json['item_description'],
      itemMainCode: json['item_main_code'],
      itemQuantity: json['item_quantity']?.toDouble(),
      itemWarehouseId: json['item_warehouse_id'],
      itemUnitPrice: json['item_unit_price']?.toDouble(),
      itemDiscount: json['item_discount']?.toDouble(),
      itemTotal: json['item_total']?.toDouble(),
      comboDescription: json['combo_description'],
      comboQuantity: json['combo_quantity']?.toDouble(),
      comboWarehouseId: json['combo_warehouse_id'],
      comboUnitPrice: json['combo_unit_price']?.toDouble(),
      comboDiscount: json['combo_discount']?.toDouble(),
      comboTotal: json['combo_total']?.toDouble(),
      note: json['note'],
      image: json['image'],
      orderIndex: json['order_index'],
      comboCode: json['combo_code'],
      itemName: json['item_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'salesOrder': salesOrder?.toJson(),
      'sales_order_id': salesOrderId,
      'lineType': lineType?.toJson(),
      'line_type_id': lineTypeId,
      'item': item?.toJson(),
      'item_id': itemId,
      'combo': combo?.toJson(),
      'combo_id': comboId,
      'title': title,
      'item_description': itemDescription,
      'item_main_code': itemMainCode,
      'item_quantity': itemQuantity,
      'item_warehouse_id': itemWarehouseId,
      'item_unit_price': itemUnitPrice,
      'item_discount': itemDiscount,
      'item_total': itemTotal,
      'combo_description': comboDescription,
      'combo_quantity': comboQuantity,
      'combo_warehouse_id': comboWarehouseId,
      'combo_unit_price': comboUnitPrice,
      'combo_discount': comboDiscount,
      'combo_total': comboTotal,
      'note': note,
      'image': image,
      'order_index': orderIndex,
      'combo_code': comboCode,
      'item_name': itemName,
    };
  }
}
