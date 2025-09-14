import '../../../Models/Country/CountryModel.dart';

abstract class CountryEvent {}
class LoadCountryCreation extends CountryEvent {
  final String search;
  final bool shouldLoad;
  final int page;
  final bool reset;
  final Country? selectedCountry;

    LoadCountryCreation({
    required this.search,
    required this.selectedCountry,
    this.shouldLoad = true,
    required this.page,
    this.reset = false,
  });
}
class ResetCountry extends CountryEvent {}

class LoadSupplierCreationLoading extends CountryEvent {
  final bool reset;
  final String? search;

  LoadSupplierCreationLoading({this.reset = false, this.search});
}

class DeleteClientEvent extends CountryEvent { final String clientId; DeleteClientEvent(this.clientId); }
// ... similarly for UpdateClientEvent, etc.
