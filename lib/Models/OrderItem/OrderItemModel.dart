import '../DiscountType/DiscountTypeModel.dart';
import '../Item/ItemModel.dart';
import '../Order/OrderModel.dart';

class OrderItem {
  int? id;
  Order? order;
  Item? item;
  DiscountType? discountType;
  double? priceAfterTax;
  int? quantity;
  double? itemDiscount;

  OrderItem({
    this.id,
    this.order,
    this.item,
    this.discountType,
    this.priceAfterTax,
    this.quantity,
    this.itemDiscount,
  });

  double get taxation => item?.taxRate ?? 0;
  dynamic get priceCurrency => item?.priceCurrency;
  dynamic get posCurrency => item?.posCurrency;
  double? get price => item?.unitPrice;
  String? get itemName => item?.itemName;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      discountType: json['discountType'] != null
          ? DiscountType.fromJson(json['discountType'])
          : null,
      priceAfterTax: (json['price_after_tax'] != null)
          ? double.tryParse(json['price_after_tax'].toString())
          : null,
      quantity: json['quantity'],
      itemDiscount: (json['item_discount'] != null)
          ? double.tryParse(json['item_discount'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order': order?.toJson(),
      'item': item?.toJson(),
      'discountType': discountType?.toJson(),
      'price_after_tax': priceAfterTax,
      'quantity': quantity,
      'item_discount': itemDiscount,
    };
  }
}
