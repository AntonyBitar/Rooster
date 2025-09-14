import '../Item/ItemModel.dart';
import '../Combo/ComboModel.dart';

import '../LigneType/LigneTypeModel.dart';
import '../Quotation/QuotationModel.dart';
class OrderLineQuotation {
  int? id;
  Quotation? quotation;
  LineType? lineType;
  Item? item;
  Combo? combo;

  int? quotationId;
  int? lineTypeId;
  String? title;
  int? itemId;
  String? itemDescription;
  String? itemMainCode;
  double? itemQuantity;
  double? itemUnitPrice;
  double? itemDiscount;
  double? itemTotal;
  int? comboId;
  String? comboDescription;
  double? comboQuantity;
  double? comboPrice;
  double? comboDiscount;
  double? comboTotal;
  String? note;
  String? image;
  int? orderIndex;

  String get comboCode => combo?.code ?? '';

  OrderLineQuotation({
    this.id,
    this.quotation,
    this.lineType,
    this.item,
    this.combo,
    this.quotationId,
    this.lineTypeId,
    this.title,
    this.itemId,
    this.itemDescription,
    this.itemMainCode,
    this.itemQuantity,
    this.itemUnitPrice,
    this.itemDiscount,
    this.itemTotal,
    this.comboId,
    this.comboDescription,
    this.comboQuantity,
    this.comboPrice,
    this.comboDiscount,
    this.comboTotal,
    this.note,
    this.image,
    this.orderIndex,
  });

  factory OrderLineQuotation.fromJson(Map<String, dynamic> json) {
    return OrderLineQuotation(
      id: json['id'],
      quotation: json['quotation'] != null ? Quotation.fromJson(json['quotation']) : null,
      lineType: json['lineType'] != null ? LineType.fromJson(json['lineType']) : null,
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      combo: json['combo'] != null ? Combo.fromJson(json['combo']) : null,
      quotationId: json['quotation_id'],
      lineTypeId: json['line_type_id'],
      title: json['title'],
      itemId: json['item_id'],
      itemDescription: json['item_description'],
      itemMainCode: json['item_main_code'],
      itemQuantity: json['item_quantity']?.toDouble(),
      itemUnitPrice: json['item_unit_price']?.toDouble(),
      itemDiscount: json['item_discount']?.toDouble(),
      itemTotal: json['item_total']?.toDouble(),
      comboId: json['combo_id'],
      comboDescription: json['combo_description'],
      comboQuantity: json['combo_quantity']?.toDouble(),
      comboPrice: json['combo_price']?.toDouble(),
      comboDiscount: json['combo_discount']?.toDouble(),
      comboTotal: json['combo_total']?.toDouble(),
      note: json['note'],
      image: json['image'],
      orderIndex: json['order_index'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quotation': quotation?.toJson(),
      'lineType': lineType?.toJson(),
      'item': item?.toJson(),
      'combo': combo?.toJson(),
      'quotation_id': quotationId,
      'line_type_id': lineTypeId,
      'title': title,
      'item_id': itemId,
      'item_description': itemDescription,
      'item_main_code': itemMainCode,
      'item_quantity': itemQuantity,
      'item_unit_price': itemUnitPrice,
      'item_discount': itemDiscount,
      'item_total': itemTotal,
      'combo_id': comboId,
      'combo_description': comboDescription,
      'combo_quantity': comboQuantity,
      'combo_price': comboPrice,
      'combo_discount': comboDiscount,
      'combo_total': comboTotal,
      'note': note,
      'image': image,
      'order_index': orderIndex,
    };
  }
}
