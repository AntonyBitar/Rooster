class LineType {
  int? id;
  String? name;

  LineType({this.id, this.name});

  factory LineType.fromJson(Map<String, dynamic> json) {
    return LineType(
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
