import '../Company/CompanyModel.dart';
import '../Item/ItemModel.dart';
import '../PosTerminal/PosTerminalModel.dart';
import '../Replenishment/ReplenishmentModel.dart';
import '../Stock/StockModel.dart';
import '../Transfer/TransferModel.dart';

class Warehouse {
  int? id;
  Company? company;
  String? name;
  bool? active;
  bool? isMain;
  bool? blocked;
  String? address;
  bool? defaultWarehouse;
  String? warehouseNumber;
  String? type; // computed
  List<Item>? items;
  List<Transfer>? transfers;
  List<Replenishment>? replenishments;
  List<Stock>? stocks;
  PosTerminal? posTerminal;

  Warehouse({
    this.id,
    this.company,
    this.name,
    this.active,
    this.isMain,
    this.blocked,
    this.address,
    this.defaultWarehouse,
    this.warehouseNumber,
    this.items,
    this.transfers,
    this.replenishments,
    this.stocks,
    this.posTerminal,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      name: json['name'],
      active: json['active'],
      isMain: json['is_main'],
      blocked: json['blocked'],
      address: json['address'],
      defaultWarehouse: json['default'],
      warehouseNumber: json['warehouse_number'],
      items: json['items'] != null
          ? (json['items'] as List).map((i) => Item.fromJson(i)).toList()
          : null,
      transfers: json['transfers'] != null
          ? (json['transfers'] as List).map((t) => Transfer.fromJson(t)).toList()
          : null,
      replenishments: json['replenishments'] != null
          ? (json['replenishments'] as List).map((r) => Replenishment.fromJson(r)).toList()
          : null,
      stocks: json['stocks'] != null
          ? (json['stocks'] as List).map((s) => Stock.fromJson(s)).toList()
          : null,
      posTerminal: json['pos_terminal'] != null ? PosTerminal.fromJson(json['pos_terminal']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'name': name,
      'active': active,
      'is_main': isMain,
      'blocked': blocked,
      'address': address,
      'default': defaultWarehouse,
      'warehouse_number': warehouseNumber,
      'items': items?.map((i) => i.toJson()).toList(),
      'transfers': transfers?.map((t) => t.toJson()).toList(),
      'replenishments': replenishments?.map((r) => r.toJson()).toList(),
      'stocks': stocks?.map((s) => s.toJson()).toList(),
      'pos_terminal': posTerminal?.toJson(),
    };
  }

  String get computedType => isMain == true ? 'main warehouse' : 'pos warehouse';
}
