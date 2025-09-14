class StateModel {
  int? id;
  int? countryId;
  String? name;

  StateModel({this.id, this.countryId, this.name});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'],
      countryId: json['country_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country_id': countryId,
      'name': name,
    };
  }
}
