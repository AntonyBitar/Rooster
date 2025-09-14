class Subref {
  int? id;
  String? name;

  Subref({this.id, this.name});

  factory Subref.fromJson(Map<String, dynamic> json) {
    return Subref(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
