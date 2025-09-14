import '../Item/ItemModel.dart';

class Package {
  int? id;
  String? name;
  List<Item>? items;

  Package({
    this.id,
    this.name,
    this.items,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'],
      name: json['name'],
      items: json['items'] != null
          ? List<Item>.from(json['items'].map((x) => Item.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'items': items?.map((x) => x.toJson()).toList(),
    };
  }
}
