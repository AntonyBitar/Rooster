import '../CashTray/CashTrayModel.dart';
import '../Company/CompanyModel.dart';
import '../Order/OrderModel.dart';
import '../PosTerminal/PosTerminalModel.dart';
import '../User/UserModel.dart';
import '../Waste/waste_model.dart';

class Session {
  int? id;
  Company? company;
  PosTerminal? posTerminal;
  User? openedByUser;
  User? closedByUser;

  String? status;
  String? sessionNumber;
  String? note;
  DateTime? openingDate;
  DateTime? closingDate;

  List<CashTrayModel>? cashTrays;
  List<Order>? orders;
  List<WasteModel>? wastes;

  Session({
    this.id,
    this.company,
    this.posTerminal,
    this.openedByUser,
    this.closedByUser,
    this.status,
    this.sessionNumber,
    this.note,
    this.openingDate,
    this.closingDate,
    this.cashTrays,
    this.orders,
    this.wastes,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      company:
      json['company'] != null ? Company.fromJson(json['company']) : null,
      posTerminal: json['posTerminal'] != null
          ? PosTerminal.fromJson(json['posTerminal'])
          : null,
      openedByUser: json['openedByUser'] != null
          ? User.fromJson(json['openedByUser'])
          : null,
      closedByUser: json['closedByUser'] != null
          ? User.fromJson(json['closedByUser'])
          : null,
      status: json['status'],
      sessionNumber: json['session_number'],
      note: json['note'],
      openingDate: json['opening_date'] != null
          ? DateTime.parse(json['opening_date'])
          : null,
      closingDate: json['closing_date'] != null
          ? DateTime.parse(json['closing_date'])
          : null,
      cashTrays: json['cashTrays'] != null
          ? List<CashTrayModel>.from(
          json['cashTrays'].map((x) => CashTrayModel.fromJson(x)))
          : [],
      orders: json['orders'] != null
          ? List<Order>.from(json['orders'].map((x) => Order.fromJson(x)))
          : [],
      wastes: json['wastes'] != null
          ? List<WasteModel>.from(json['wastes'].map((x) => WasteModel.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'posTerminal': posTerminal?.toJson(),
      'openedByUser': openedByUser?.toJson(),
      'closedByUser': closedByUser?.toJson(),
      'status': status,
      'session_number': sessionNumber,
      'note': note,
      'opening_date': openingDate?.toIso8601String(),
      'closing_date': closingDate?.toIso8601String(),
      'cashTrays': cashTrays?.map((x) => x.toJson()).toList(),
      'orders': orders?.map((x) => x.toJson()).toList(),
      'wastes': wastes?.map((x) => x.toJson()).toList(),
    };
  }
}
