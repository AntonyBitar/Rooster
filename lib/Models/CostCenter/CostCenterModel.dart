import 'package:rooster_app/Models/Company/CompanyModel.dart';

class CostCenterModel {
  int? id;
  String? name;
  String? description;
  Company? company;
  int? parentId;
  List<CostCenterModel> children = [];
  bool isNew; // new property to track newly added nodes

  CostCenterModel({
    this.id,
    this.name,
    this.description,
    this.company,
    this.parentId,
    List<CostCenterModel>? children,
    this.isNew = false, // default is false
  }) {
    if (children != null) {
      this.children = children;
    }
  }

  CostCenterModel copy() {
    return CostCenterModel(
      id: id,
      name: name,
      description: description,
      company: company,
      parentId: parentId,
      children: children.map((e) => e.copy()).toList(),
      isNew: isNew,
    );
  }

  factory CostCenterModel.fromJson(Map<String, dynamic> json) {
    return CostCenterModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      parentId: json['parentId'],
      children: json['children'] != null
          ? (json['children'] as List)
          .map((child) => CostCenterModel.fromJson(child))
          .toList()
          : [],
      isNew: false, // nodes from backend are not new
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'company_id': company?.id,
      'parent_cost_center_id': parentId,
      'children': children.map((c) => c.toJson()).toList(),
    };
  }
}
