import '../Company/CompanyModel.dart';

class CompanyHeader {
  int? id;
  Company? company;
  int? companyId;
  String? headerName;
  String? logo;
  String? fullCompanyName;
  String? address;
  String? mobileCode;
  String? mobileNumber;
  String? email;
  String? phoneCode;
  String? phoneNumber;
  String? trn;
  String? bankInfo;
  bool? localPayments;
  double? vat;
  bool? companySubjectToVat;

  CompanyHeader({
    this.id,
    this.company,
    this.companyId,
    this.headerName,
    this.logo,
    this.fullCompanyName,
    this.address,
    this.mobileCode,
    this.mobileNumber,
    this.email,
    this.phoneCode,
    this.phoneNumber,
    this.trn,
    this.bankInfo,
    this.localPayments,
    this.vat,
    this.companySubjectToVat,
  });

  factory CompanyHeader.fromJson(Map<String, dynamic> json) {
    return CompanyHeader(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      companyId: json['company_id'],
      headerName: json['header_name'],
      logo: json['logo'],
      fullCompanyName: json['full_company_name'],
      address: json['address'],
      mobileCode: json['mobile_code'],
      mobileNumber: json['mobile_number'],
      email: json['email'],
      phoneCode: json['phone_code'],
      phoneNumber: json['phone_number'],
      trn: json['trn'],
      bankInfo: json['bank_info'],
      localPayments: json['local_payments'],
      vat: json['vat']?.toDouble(),
      companySubjectToVat: json['company_subject_to_vat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'company_id': companyId,
      'header_name': headerName,
      'logo': logo,
      'full_company_name': fullCompanyName,
      'address': address,
      'mobile_code': mobileCode,
      'mobile_number': mobileNumber,
      'email': email,
      'phone_code': phoneCode,
      'phone_number': phoneNumber,
      'trn': trn,
      'bank_info': bankInfo,
      'local_payments': localPayments,
      'vat': vat,
      'company_subject_to_vat': companySubjectToVat,
    };
  }
}
