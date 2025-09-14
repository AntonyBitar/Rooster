import 'package:rooster_app/Models/Country/CountryModel.dart';

class City {
  int? id;
  int? stateId;
  Country? country;
  String? name;

  City({this.id, this.stateId, this.country, this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      stateId: json['state_id'],
      country: json['country'] != null? Country.fromJson(json['country']) : null,
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state_id': stateId,
      'country_id': country!.id,
      'name': name,
    };
  }
}
