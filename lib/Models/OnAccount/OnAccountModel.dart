
import '../CashTray/CashTrayModel.dart';
import '../Client/ClientModel.dart';
import '../Order/OrderModel.dart';
import '../Session/SessionModel.dart';
import '../User/UserModel.dart';

class OnAccount {
  int? id;
  Order? order;
  Session? session;
  CashTrayModel? cashTray;
  User? cashier;
  Client? customer;

  double? primaryCurrencyRemainingAmount;
  double? posCurrencyRemainingAmount;
  DateTime? dueDate;

  OnAccount({
    this.id,
    this.order,
    this.session,
    this.cashTray,
    this.cashier,
    this.customer,
    this.primaryCurrencyRemainingAmount,
    this.posCurrencyRemainingAmount,
    this.dueDate,
  });

  factory OnAccount.fromJson(Map<String, dynamic> json) {
    return OnAccount(
      id: json['id'],
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
      session:
      json['session'] != null ? Session.fromJson(json['session']) : null,
      cashTray: json['cashTray'] != null
          ? CashTrayModel.fromJson(json['cashTray'])
          : null,
      cashier:
      json['cashier'] != null ? User.fromJson(json['cashier']) : null,
      customer:
      json['customer'] != null ? Client.fromJson(json['customer']) : null,
      primaryCurrencyRemainingAmount:
      json['primary_currency_remaining_amount'] != null
          ? double.tryParse(
          json['primary_currency_remaining_amount'].toString())
          : null,
      posCurrencyRemainingAmount:
      json['pos_currency_remaining_amount'] != null
          ? double.tryParse(
          json['pos_currency_remaining_amount'].toString())
          : null,
      dueDate:
      json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order': order?.toJson(),
      'session': session?.toJson(),
      'cashTray': cashTray?.toJson(),
      'cashier': cashier?.toJson(),
      'customer': customer?.toJson(),
      'primary_currency_remaining_amount': primaryCurrencyRemainingAmount,
      'pos_currency_remaining_amount': posCurrencyRemainingAmount,
      'due_date': dueDate?.toIso8601String(),
    };
  }
}
