import '../City/CityModel.dart';

class PaginatedCities {
  final List<City> cities;
  final bool hasMore;
  PaginatedCities({required this.cities, required this.hasMore});
}
