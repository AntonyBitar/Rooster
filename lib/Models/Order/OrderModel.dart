
import '../CashingMethod/CashingMethodModel.dart';
import '../Client/ClientModel.dart';
import '../Currency/CurrencyModel.dart';
import '../DiscountType/DiscountTypeModel.dart';
import '../OnAccount/OnAccountModel.dart';
import '../OrderItem/OrderItemModel.dart';
import '../PaymentTerm/PaymentTermModel.dart';
import '../Session/SessionModel.dart';
import '../User/UserModel.dart';

class Order {
  int? id;
  User? cashier;
  User? finishedByUser;
  Client? client;
  PaymentTerm? paymentTerm;
  DiscountType? discountType;
  Currency? primaryCurrency;
  Currency? posCurrency;
  Session? session;

  List<OrderItem>? orderItems;
  List<OnAccount>? onAccounts;
  List<CashingMethod>? cashingMethods;

  String? orderNumber;
  String? docNumber;
  String? paymentStatus;
  String? type;
  String? status;
  String? deliveryStatus;
  String? note;

  double? primaryCurrencyTaxValue;
  double? primaryCurrencyDiscountValue;
  double? posCurrencyTaxValue;
  double? posCurrencyDiscountValue;
  double? primaryCurrencyTotal;
  double? posCurrencyTotal;
  double? primaryCurrencyChange;
  double? posCurrencyChange;
  double? primaryCurrencyRemaining;
  double? posCurrencyRemaining;
  double? primaryCurrencyGrantedDiscount;
  double? posCurrencyGrantedDiscount;
  double? customDiscountPercentage;
  double? posCurrencyCustomDiscountValue;

  DateTime? openedAt;
  DateTime? closedAt;

  Order({
    this.id,
    this.cashier,
    this.finishedByUser,
    this.client,
    this.paymentTerm,
    this.discountType,
    this.primaryCurrency,
    this.posCurrency,
    this.session,
    this.orderItems,
    this.onAccounts,
    this.cashingMethods,
    this.orderNumber,
    this.docNumber,
    this.paymentStatus,
    this.type,
    this.status,
    this.deliveryStatus,
    this.note,
    this.primaryCurrencyTaxValue,
    this.primaryCurrencyDiscountValue,
    this.posCurrencyTaxValue,
    this.posCurrencyDiscountValue,
    this.primaryCurrencyTotal,
    this.posCurrencyTotal,
    this.primaryCurrencyChange,
    this.posCurrencyChange,
    this.primaryCurrencyRemaining,
    this.posCurrencyRemaining,
    this.primaryCurrencyGrantedDiscount,
    this.posCurrencyGrantedDiscount,
    this.customDiscountPercentage,
    this.posCurrencyCustomDiscountValue,
    this.openedAt,
    this.closedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      cashier: json['cashier'] != null ? User.fromJson(json['cashier']) : null,
      finishedByUser: json['finishedByUser'] != null
          ? User.fromJson(json['finishedByUser'])
          : null,
      client:
      json['client'] != null ? Client.fromJson(json['client']) : null,
      paymentTerm: json['paymentTerm'] != null
          ? PaymentTerm.fromJson(json['paymentTerm'])
          : null,
      discountType: json['discountType'] != null
          ? DiscountType.fromJson(json['discountType'])
          : null,
      primaryCurrency: json['primaryCurrency'] != null
          ? Currency.fromJson(json['primaryCurrency'])
          : null,
      posCurrency: json['posCurrency'] != null
          ? Currency.fromJson(json['posCurrency'])
          : null,
      session:
      json['session'] != null ? Session.fromJson(json['session']) : null,
      orderItems: json['orderItems'] != null
          ? List<OrderItem>.from(
          json['orderItems'].map((x) => OrderItem.fromJson(x)))
          : [],
      onAccounts: json['onAccounts'] != null
          ? List<OnAccount>.from(
          json['onAccounts'].map((x) => OnAccount.fromJson(x)))
          : [],
      cashingMethods: json['cashingMethods'] != null
          ? List<CashingMethod>.from(
          json['cashingMethods'].map((x) => CashingMethod.fromJson(x)))
          : [],
      orderNumber: json['order_number'],
      docNumber: json['doc_number'],
      paymentStatus: json['payment_status'],
      type: json['type'],
      status: json['status'],
      deliveryStatus: json['delivery_status'],
      note: json['note'],
      primaryCurrencyTaxValue: (json['primary_currency_tax_value'] != null)
          ? double.tryParse(json['primary_currency_tax_value'].toString())
          : null,
      primaryCurrencyDiscountValue: (json['primary_currency_discount_value'] !=
          null)
          ? double.tryParse(json['primary_currency_discount_value'].toString())
          : null,
      posCurrencyTaxValue: (json['pos_currency_tax_value'] != null)
          ? double.tryParse(json['pos_currency_tax_value'].toString())
          : null,
      posCurrencyDiscountValue: (json['pos_currency_discount_value'] != null)
          ? double.tryParse(json['pos_currency_discount_value'].toString())
          : null,
      primaryCurrencyTotal: (json['primary_currency_total'] != null)
          ? double.tryParse(json['primary_currency_total'].toString())
          : null,
      posCurrencyTotal: (json['pos_currency_total'] != null)
          ? double.tryParse(json['pos_currency_total'].toString())
          : null,
      primaryCurrencyChange: (json['primary_currency_change'] != null)
          ? double.tryParse(json['primary_currency_change'].toString())
          : null,
      posCurrencyChange: (json['pos_currency_change'] != null)
          ? double.tryParse(json['pos_currency_change'].toString())
          : null,
      primaryCurrencyRemaining: (json['primary_currency_remaining'] != null)
          ? double.tryParse(json['primary_currency_remaining'].toString())
          : null,
      posCurrencyRemaining: (json['pos_currency_remaining'] != null)
          ? double.tryParse(json['pos_currency_remaining'].toString())
          : null,
      primaryCurrencyGrantedDiscount:
      (json['primary_currency_granted_discount'] != null)
          ? double.tryParse(
          json['primary_currency_granted_discount'].toString())
          : null,
      posCurrencyGrantedDiscount: (json['pos_currency_granted_discount'] !=
          null)
          ? double.tryParse(json['pos_currency_granted_discount'].toString())
          : null,
      customDiscountPercentage: (json['custom_discount_percentage'] != null)
          ? double.tryParse(json['custom_discount_percentage'].toString())
          : null,
      posCurrencyCustomDiscountValue:
      (json['pos_currency_custom_discount_value'] != null)
          ? double.tryParse(
          json['pos_currency_custom_discount_value'].toString())
          : null,
      openedAt: json['opened_at'] != null
          ? DateTime.parse(json['opened_at'])
          : null,
      closedAt: json['closed_at'] != null
          ? DateTime.parse(json['closed_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cashier': cashier?.toJson(),
      'finishedByUser': finishedByUser?.toJson(),
      'client': client?.toJson(),
      'paymentTerm': paymentTerm?.toJson(),
      'discountType': discountType?.toJson(),
      'primaryCurrency': primaryCurrency?.toJson(),
      'posCurrency': posCurrency?.toJson(),
      'session': session?.toJson(),
      'orderItems': orderItems?.map((x) => x.toJson()).toList(),
      'onAccounts': onAccounts?.map((x) => x.toJson()).toList(),
      'cashingMethods': cashingMethods?.map((x) => x.toJson()).toList(),
      'order_number': orderNumber,
      'doc_number': docNumber,
      'payment_status': paymentStatus,
      'type': type,
      'status': status,
      'delivery_status': deliveryStatus,
      'note': note,
      'primary_currency_tax_value': primaryCurrencyTaxValue,
      'primary_currency_discount_value': primaryCurrencyDiscountValue,
      'pos_currency_tax_value': posCurrencyTaxValue,
      'pos_currency_discount_value': posCurrencyDiscountValue,
      'primary_currency_total': primaryCurrencyTotal,
      'pos_currency_total': posCurrencyTotal,
      'primary_currency_change': primaryCurrencyChange,
      'pos_currency_change': posCurrencyChange,
      'primary_currency_remaining': primaryCurrencyRemaining,
      'pos_currency_remaining': posCurrencyRemaining,
      'primary_currency_granted_discount': primaryCurrencyGrantedDiscount,
      'pos_currency_granted_discount': posCurrencyGrantedDiscount,
      'custom_discount_percentage': customDiscountPercentage,
      'pos_currency_custom_discount_value': posCurrencyCustomDiscountValue,
      'opened_at': openedAt?.toIso8601String(),
      'closed_at': closedAt?.toIso8601String(),
    };
  }
}

