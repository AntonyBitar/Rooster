
import '../Client/ClientModel.dart';
import '../Company/CompanyModel.dart';

class ClientAddress {
  int? id;
  Company? company;
  Client? client;

  int? clientId;
  int? companyId;
  int? type;
  String? name;
  String? title;
  String? jobPosition;
  String? phoneCode;
  String? phoneNumber;
  String? extension;
  String? mobileCode;
  String? mobileNumber;
  String? email;
  String? deliveryAddress;
  String? note;
  String? internalNote;

  ClientAddress({
    this.id,
    this.company,
    this.client,
    this.clientId,
    this.companyId,
    this.type,
    this.name,
    this.title,
    this.jobPosition,
    this.phoneCode,
    this.phoneNumber,
    this.extension,
    this.mobileCode,
    this.mobileNumber,
    this.email,
    this.deliveryAddress,
    this.note,
    this.internalNote,
  });

  factory ClientAddress.fromJson(Map<String, dynamic> json) {
    return ClientAddress(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      client: json['client'] != null ? Client.fromJson(json['client']) : null,
      clientId: json['client_id'],
      companyId: json['company_id'],
      type: json['type'],
      name: json['name'],
      title: json['title'],
      jobPosition: json['job_position'],
      phoneCode: json['phone_code'],
      phoneNumber: json['phone_number'],
      extension: json['extension'],
      mobileCode: json['mobile_code'],
      mobileNumber: json['mobile_number'],
      email: json['email'],
      deliveryAddress: json['delivery_address'],
      note: json['note'],
      internalNote: json['internal_note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'client': client?.toJson(),
      'client_id': clientId,
      'company_id': companyId,
      'type': type,
      'name': name,
      'title': title,
      'job_position': jobPosition,
      'phone_code': phoneCode,
      'phone_number': phoneNumber,
      'extension': extension,
      'mobile_code': mobileCode,
      'mobile_number': mobileNumber,
      'email': email,
      'delivery_address': deliveryAddress,
      'note': note,
      'internal_note': internalNote,
    };
  }
}
