import '../Currency/CurrencyModel.dart';
import '../Order/OrderModel.dart';
import '../PosTerminal/PosTerminalModel.dart';
import '../Session/SessionModel.dart';
import '../User/UserModel.dart';

class CashTrayModel {
  int? id;
  int? companyId;
  int? posTerminalId;
  int? sessionId;
  int? userId;
  int? primaryCurrencyId;
  int? posCurrencyId;

  double? primaryCurrencyRate;
  double? posCurrencyRate;
  double? primaryCurrencyOpeningAmount;
  double? primaryCurrencyClosingAmount;
  double? posCurrencyOpeningAmount;
  double? posCurrencyClosingAmount;
  double? nonCashPrimaryCurrencyAmount;
  double? nonCashPosCurrencyAmount;

  String? trayNumber;
  String? status;

  PosTerminal? posTerminal;
  User? cashier;
  Session? session;
  Currency? primaryCurrency;
  Currency? posCurrency;
  List<Order>? orders;

  CashTrayModel({
    this.id,
    this.companyId,
    this.posTerminalId,
    this.sessionId,
    this.userId,
    this.primaryCurrencyId,
    this.posCurrencyId,
    this.primaryCurrencyRate,
    this.posCurrencyRate,
    this.primaryCurrencyOpeningAmount,
    this.primaryCurrencyClosingAmount,
    this.posCurrencyOpeningAmount,
    this.posCurrencyClosingAmount,
    this.nonCashPrimaryCurrencyAmount,
    this.nonCashPosCurrencyAmount,
    this.trayNumber,
    this.status,
    this.posTerminal,
    this.cashier,
    this.session,
    this.primaryCurrency,
    this.posCurrency,
    this.orders,
  });

  factory CashTrayModel.fromJson(Map<String, dynamic> json) {
    return CashTrayModel(
      id: json['id'],
      companyId: json['company_id'],
      posTerminalId: json['pos_terminal_id'],
      sessionId: json['session_id'],
      userId: json['user_id'],
      primaryCurrencyId: json['primary_currency_id'],
      posCurrencyId: json['pos_currency_id'],
      primaryCurrencyRate: (json['primary_currency_rate'] as num?)?.toDouble(),
      posCurrencyRate: (json['pos_currency_rate'] as num?)?.toDouble(),
      primaryCurrencyOpeningAmount: (json['primary_currency_opening_amount'] as num?)?.toDouble(),
      primaryCurrencyClosingAmount: (json['primary_currency_closing_amount'] as num?)?.toDouble(),
      posCurrencyOpeningAmount: (json['pos_currency_opening_amount'] as num?)?.toDouble(),
      posCurrencyClosingAmount: (json['pos_currency_closing_amount'] as num?)?.toDouble(),
      nonCashPrimaryCurrencyAmount: (json['non_cash_primary_currency_amount'] as num?)?.toDouble(),
      nonCashPosCurrencyAmount: (json['non_cash_pos_currency_amount'] as num?)?.toDouble(),
      trayNumber: json['tray_number'],
      status: json['status'],
      posTerminal: json['posTerminal'] != null ? PosTerminal.fromJson(json['posTerminal']) : null,
      cashier: json['cashier'] != null ? User.fromJson(json['cashier']) : null,
      session: json['session'] != null ? Session.fromJson(json['session']) : null,
      primaryCurrency: json['primaryCurrency'] != null ? Currency.fromJson(json['primaryCurrency']) : null,
      posCurrency: json['posCurrency'] != null ? Currency.fromJson(json['posCurrency']) : null,
      orders: json['orders'] != null
          ? List<Order>.from(json['orders'].map((x) => Order.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'pos_terminal_id': posTerminalId,
      'session_id': sessionId,
      'user_id': userId,
      'primary_currency_id': primaryCurrencyId,
      'pos_currency_id': posCurrencyId,
      'primary_currency_rate': primaryCurrencyRate,
      'pos_currency_rate': posCurrencyRate,
      'primary_currency_opening_amount': primaryCurrencyOpeningAmount,
      'primary_currency_closing_amount': primaryCurrencyClosingAmount,
      'pos_currency_opening_amount': posCurrencyOpeningAmount,
      'pos_currency_closing_amount': posCurrencyClosingAmount,
      'non_cash_primary_currency_amount': nonCashPrimaryCurrencyAmount,
      'non_cash_pos_currency_amount': nonCashPosCurrencyAmount,
      'tray_number': trayNumber,
      'status': status,
      'posTerminal': posTerminal?.toJson(),
      'cashier': cashier?.toJson(),
      'session': session?.toJson(),
      'primaryCurrency': primaryCurrency?.toJson(),
      'posCurrency': posCurrency?.toJson(),
      'orders': orders?.map((x) => x.toJson()).toList(),
    };
  }
}
