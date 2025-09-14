import '../Company/CompanyModel.dart';
import '../Item/ItemModel.dart';

class ItemGroup {
  int? id;
  Company? company;
  String? code;
  String? name;
  bool? active;
  List<Item>? items;
  List<ItemGroup>? childrenRecursive;

  ItemGroup({
    this.id,
    this.company,
    this.code,
    this.name,
    this.active,
    this.items,
    this.childrenRecursive,
  });

  String get showName {
    // Logic to replicate PHP show_name
    // This is simplified; for hierarchy you may need recursion
    return code! + name!;
  }

  String get rootName {
    return name!;
  }

  factory ItemGroup.fromJson(Map<String, dynamic> json) {
    return ItemGroup(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      active: json['active'],
      company:
      json['company'] != null ? Company.fromJson(json['company']) : null,
      items: json['items'] != null
          ? List<Item>.from(json['items'].map((x) => Item.fromJson(x)))
          : [],
      childrenRecursive: json['childrenRecursive'] != null
          ? List<ItemGroup>.from(
          json['childrenRecursive'].map((x) => ItemGroup.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'active': active,
      'company': company?.toJson(),
      'items': items?.map((x) => x.toJson()).toList(),
      'childrenRecursive': childrenRecursive?.map((x) => x.toJson()).toList(),
    };
  }
}
