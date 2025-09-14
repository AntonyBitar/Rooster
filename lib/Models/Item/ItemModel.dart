import '../../Screens/Combo/combo.dart';
import '../AlternativeCode/AlternativeCodeModel.dart';
import '../Company/CompanyModel.dart';
import '../Inventory/inventory_model.dart';
import '../ItemGroup/ItemGroupModel.dart';
import '../ItemImage/ItemImageModel.dart';
import '../OrderItem/OrderItemModel.dart';
import '../Package/PackageModel.dart';
import '../PriceChanges/PriceChangesModel.dart';
import '../ReplenishmentItem/ReplenishmentItemModel.dart';
import '../Stock/StockModel.dart';
import '../Subref/SubrefModel.dart';
import '../SupplierCode/SupplierCodeModel.dart';
import '../TransferItem/TransferItemModel.dart';
import '../WareHouse/WareHouseModel.dart';
import '../Waste/waste_model.dart';

class Item {
  int? id;
  Company? company;
  Warehouse? warehouse;
  ItemType? itemType;
  String? mainCode;
  String? itemCode;
  String? itemName;
  String? printMainCode;
  String? imgUrl;
  String? shortDescription;
  bool? showOnPos;
  String? mainDescription;
  String? secondLanguageDescription;
  TaxationGroup? taxationGroup;
  Subref? subref;
  bool? canBeSold;
  bool? canBePurchased;
  int? warranty;
  DateTime? lastAllowedPurchaseDate;
  double? unitCost;
  double? decimalCost;
  Currency? currency;
  Currency? posCurrency;
  Currency? priceCurrency;
  double? posPrice;
  double? quantity;
  double? unitPrice;
  double? decimalPrice;
  double? lineDiscountLimit;
  Package? package;
  int? defaultTransactionPackageId;
  String? packageUnitName;
  double? packageUnitQuantity;
  String? packageSetName;
  double? packageSetQuantity;
  String? packageSupersetName;
  double? packageSupersetQuantity;
  String? packagePaletteName;
  double? packagePaletteQuantity;
  String? packageContainerName;
  double? packageContainerQuantity;
  double? decimalQuantity;
  bool? isBlocked;
  bool? active;

  double? taxRate;
  double? totalQuantities;
  List<Warehouse>? warehouses;
  List<SupplierCode>? supplierCodes;
  List<AlternativeCode>? alternativeCodes;
  List<Barcode>? barcodes;
  List<Combo>? combos;
  Category? category;
  List<ItemGroup>? itemGroups;
  List<ItemImage>? images;
  List<OrderItem>? orderItems;
  List<ReplenishmentItem>? replenishments;
  List<WasteModel>? wastes;
  List<PriceChange>? priceChanges;
  List<Stock>? stocks;
  List<TransferItem>? transferItems;

  Item({
    this.id,
    this.company,
    this.warehouse,
    this.itemType,
    this.mainCode,
    this.itemCode,
    this.itemName,
    this.printMainCode,
    this.imgUrl,
    this.shortDescription,
    this.showOnPos,
    this.mainDescription,
    this.secondLanguageDescription,
    this.taxationGroup,
    this.subref,
    this.canBeSold,
    this.canBePurchased,
    this.warranty,
    this.lastAllowedPurchaseDate,
    this.unitCost,
    this.decimalCost,
    this.currency,
    this.posCurrency,
    this.priceCurrency,
    this.posPrice,
    this.quantity,
    this.unitPrice,
    this.decimalPrice,
    this.lineDiscountLimit,
    this.package,
    this.defaultTransactionPackageId,
    this.packageUnitName,
    this.packageUnitQuantity,
    this.packageSetName,
    this.packageSetQuantity,
    this.packageSupersetName,
    this.packageSupersetQuantity,
    this.packagePaletteName,
    this.packagePaletteQuantity,
    this.packageContainerName,
    this.packageContainerQuantity,
    this.decimalQuantity,
    this.isBlocked,
    this.active,
    this.taxRate,
    this.totalQuantities,
    this.warehouses,
    this.supplierCodes,
    this.alternativeCodes,
    this.barcodes,
    this.combos,
    this.category,
    this.itemGroups,
    this.images,
    this.orderItems,
    this.replenishments,
    this.wastes,
    this.priceChanges,
    this.stocks,
    this.transferItems,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      warehouse: json['warehouse'] != null ? Warehouse.fromJson(json['warehouse']) : null,
      itemType: json['item_type'] != null ? ItemType.fromJson(json['item_type']) : null,
      mainCode: json['main_code'],
      itemCode: json['item_code'],
      itemName: json['item_name'],
      printMainCode: json['print_main_code'],
      imgUrl: json['img_url'],
      shortDescription: json['short_description'],
      showOnPos: json['show_on_pos'],
      mainDescription: json['main_description'],
      secondLanguageDescription: json['second_language_description'],
      taxationGroup: json['taxation_group'] != null ? TaxationGroup.fromJson(json['taxation_group']) : null,
      subref: json['subref'] != null ? Subref.fromJson(json['subref']) : null,
      canBeSold: json['can_be_sold'],
      canBePurchased: json['can_be_purchased'],
      warranty: json['warranty'],
      lastAllowedPurchaseDate: json['last_allowed_purchase_date'] != null ? DateTime.parse(json['last_allowed_purchase_date']) : null,
      unitCost: (json['unit_cost'] != null) ? double.tryParse(json['unit_cost'].toString()) : null,
      decimalCost: (json['decimal_cost'] != null) ? double.tryParse(json['decimal_cost'].toString()) : null,
      currency: json['currency'] != null ? Currency.fromJson(json['currency']) : null,
      posCurrency: json['pos_currency'] != null ? Currency.fromJson(json['pos_currency']) : null,
      priceCurrency: json['price_currency'] != null ? Currency.fromJson(json['price_currency']) : null,
      posPrice: (json['pos_price'] != null) ? double.tryParse(json['pos_price'].toString()) : null,
      quantity: (json['quantity'] != null) ? double.tryParse(json['quantity'].toString()) : null,
      unitPrice: (json['unit_price'] != null) ? double.tryParse(json['unit_price'].toString()) : null,
      decimalPrice: (json['decimal_price'] != null) ? double.tryParse(json['decimal_price'].toString()) : null,
      lineDiscountLimit: (json['line_discount_limit'] != null) ? double.tryParse(json['line_discount_limit'].toString()) : null,
      package: json['package'] != null ? Package.fromJson(json['package']) : null,
      defaultTransactionPackageId: json['default_transaction_package_id'],
      packageUnitName: json['package_unit_name'],
      packageUnitQuantity: (json['package_unit_quantity'] != null) ? double.tryParse(json['package_unit_quantity'].toString()) : null,
      // … Continue for all remaining fields similarly …
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'warehouse': warehouse?.toJson(),
      'item_type': itemType?.toJson(),
      'main_code': mainCode,
      'item_code': itemCode,
      'item_name': itemName,
      'print_main_code': printMainCode,
      'img_url': imgUrl,
      'short_description': shortDescription,
      'show_on_pos': showOnPos,
      'main_description': mainDescription,
      'second_language_description': secondLanguageDescription,
      'taxation_group': taxationGroup?.toJson(),
      'subref': subref?.toJson(),
      'can_be_sold': canBeSold,
      'can_be_purchased': canBePurchased,
      'warranty': warranty,
      'last_allowed_purchase_date': lastAllowedPurchaseDate?.toIso8601String(),
      'unit_cost': unitCost,
      'decimal_cost': decimalCost,
      'currency': currency?.toJson(),
      'pos_currency': posCurrency?.toJson(),
      'price_currency': priceCurrency?.toJson(),
      'pos_price': posPrice,
      'quantity': quantity,
      'unit_price': unitPrice,
      'decimal_price': decimalPrice,
      'line_discount_limit': lineDiscountLimit,
      'package': package?.toJson(),
      'default_transaction_package_id': defaultTransactionPackageId,
      'package_unit_name': packageUnitName,
      'package_unit_quantity': packageUnitQuantity,
      // … Continue for all remaining fields similarly …
    };
  }
}
