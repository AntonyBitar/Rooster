import 'package:rooster_app/Models/Supplier/SupplierModel.dart';

import '../../../Models/Country/CountryModel.dart';

abstract class CountryState {}

  class CountryInitial extends CountryState {}



class CountryLoadSuccess extends CountryState {
  List<Country> countries;
  bool hasReachedMax;
  Country? country;
  CountryLoadSuccess({
    required this.countries,
    required this.hasReachedMax,
    required this.country,
  });
}


class CountryLoadFailure extends CountryState {
  final String error;

  CountryLoadFailure(this.error);
}
