import '../Currency/CurrencyModel.dart';
import '../Item/ItemModel.dart';

class ComboItem {
  int? id;
  Item? item;
  int? itemId;
  Currency? currency;
  int? currencyId;
  String? description;
  double? unitPrice;
  double? quantity;
  double? discount;
  double? total;
  String? itemName;

  ComboItem({
    this.id,
    this.item,
    this.itemId,
    this.currency,
    this.currencyId,
    this.description,
    this.unitPrice,
    this.quantity,
    this.discount,
    this.total,
    this.itemName,
  });

  factory ComboItem.fromJson(Map<String, dynamic> json) {
    return ComboItem(
      id: json['id'],
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      itemId: json['item_id'],
      currency: json['currency'] != null ? Currency.fromJson(json['currency']) : null,
      currencyId: json['currency_id'],
      description: json['description'],
      unitPrice: json['unit_price']?.toDouble(),
      quantity: json['quantity']?.toDouble(),
      discount: json['discount']?.toDouble(),
      total: json['total']?.toDouble(),
      itemName: json['item_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item?.toJson(),
      'item_id': itemId,
      'currency': currency?.toJson(),
      'currency_id': currencyId,
      'description': description,
      'unit_price': unitPrice,
      'quantity': quantity,
      'discount': discount,
      'total': total,
      'item_name': itemName,
    };
  }
}
