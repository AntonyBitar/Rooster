import '../Company/CompanyModel.dart';

class TermsAndCondition {
  int? id;
  Company? company;
  int? companyId;
  String? termsAndConditions;

  TermsAndCondition({
    this.id,
    this.company,
    this.companyId,
    this.termsAndConditions,
  });

  factory TermsAndCondition.fromJson(Map<String, dynamic> json) {
    return TermsAndCondition(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      companyId: json['company_id'],
      termsAndConditions: json['terms_and_conditions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'company_id': companyId,
      'terms_and_conditions': termsAndConditions,
    };
  }
}
