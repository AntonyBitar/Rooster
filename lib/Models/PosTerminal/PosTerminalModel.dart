import '../Company/CompanyModel.dart';
import '../User/UserModel.dart';
import '../WareHouse/WareHouseModel.dart';

class PosTerminal {
  int? id;
  Company? company;
  Warehouse? warehouse;
  String? name;
  String? address;
  String? posNumber;
  List<User>? users;

  PosTerminal({
    this.id,
    this.company,
    this.warehouse,
    this.name,
    this.address,
    this.posNumber,
    this.users,
  });

  factory PosTerminal.fromJson(Map<String, dynamic> json) {
    return PosTerminal(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      warehouse: json['warehouse'] != null ? Warehouse.fromJson(json['warehouse']) : null,
      name: json['name'],
      address: json['address'],
      posNumber: json['pos_number'],
      users: json['users'] != null
          ? (json['users'] as List).map((u) => User.fromJson(u)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'warehouse': warehouse?.toJson(),
      'name': name,
      'address': address,
      'pos_number': posNumber,
      'users': users?.map((u) => u.toJson()).toList(),
    };
  }
}
