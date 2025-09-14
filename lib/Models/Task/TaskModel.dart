import '../Company/CompanyModel.dart';
import '../Quotation/QuotationModel.dart';
import '../User/UserModel.dart';

class Task {
  int? id;
  Company? company;
  int? companyId;
  Quotation? quotation;
  int? quotationId;
  User? user;
  int? userId;
  User? scheduledByUser;
  int? scheduledByUserId;
  String? summary;
  String? taskType;
  String? note;
  String? date;
  String? status;

  Task({
    this.id,
    this.company,
    this.companyId,
    this.quotation,
    this.quotationId,
    this.user,
    this.userId,
    this.scheduledByUser,
    this.scheduledByUserId,
    this.summary,
    this.taskType,
    this.note,
    this.date,
    this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      companyId: json['company_id'],
      quotation: json['quotation'] != null ? Quotation.fromJson(json['quotation']) : null,
      quotationId: json['quotation_id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      userId: json['user_id'],
      scheduledByUser: json['scheduledByUser'] != null ? User.fromJson(json['scheduledByUser']) : null,
      scheduledByUserId: json['scheduled_by_user_id'],
      summary: json['summary'],
      taskType: json['task_type'],
      note: json['note'],
      date: json['date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'company_id': companyId,
      'quotation': quotation?.toJson(),
      'quotation_id': quotationId,
      'user': user?.toJson(),
      'user_id': userId,
      'scheduledByUser': scheduledByUser?.toJson(),
      'scheduled_by_user_id': scheduledByUserId,
      'summary': summary,
      'task_type': taskType,
      'note': note,
      'date': date,
      'status': status,
    };
  }
}
