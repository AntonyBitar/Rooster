class CommissionMethod {
  int? id;
  String? title;
  bool? active;

  CommissionMethod({this.id, this.title, this.active});

  factory CommissionMethod.fromJson(Map<String, dynamic> json) {
    return CommissionMethod(
      id: json['id'],
      title: json['title'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'active': active,
    };
  }
}
