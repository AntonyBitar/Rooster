
import '../Country/CountryModel.dart';

class PaginatedCountry {
  final List<Country> countries;
  final bool hasMore;
  PaginatedCountry({required this.countries, required this.hasMore});
}
