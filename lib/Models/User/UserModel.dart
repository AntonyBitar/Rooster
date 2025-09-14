import '../Company/CompanyModel.dart';
import '../PosTerminal/PosTerminalModel.dart';

class User {
  int? id;
  Company? company;
  PosTerminal? posTerminal;
  String? name;
  String? email;
  String? password;
  bool? isSalesperson;
  bool? active;

  User({
    this.id,
    this.company,
    this.posTerminal,
    this.name,
    this.email,
    this.password,
    this.isSalesperson,
    this.active,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      posTerminal: json['pos_terminal'] != null ? PosTerminal.fromJson(json['pos_terminal']) : null,
      name: json['name'],
      email: json['email'],
      password: json['password'],
      isSalesperson: json['is_salesperson'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'pos_terminal': posTerminal?.toJson(),
      'name': name,
      'email': email,
      'password': password,
      'is_salesperson': isSalesperson,
      'active': active,
    };
  }
}
