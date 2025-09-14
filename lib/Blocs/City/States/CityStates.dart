import 'package:rooster_app/Models/City/CityModel.dart';
import 'package:rooster_app/Models/Supplier/SupplierModel.dart';

abstract class CitiesState {}


  class CitiesLoading extends CitiesState {}

class CitiesLoadSuccess extends CitiesState {
  List<City> cities;
  City? selectedCity;
  final bool hasReachedMax;

  CitiesLoadSuccess({
    required this.cities,
    required this.hasReachedMax,
    required this.selectedCity,

  });
}

class CitiesLoadFailure extends CitiesState {
  final String error;

  CitiesLoadFailure(this.error);
}
