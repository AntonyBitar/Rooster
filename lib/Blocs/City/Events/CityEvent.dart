import '../../../Models/City/CityModel.dart';

abstract class CitiesEvent {}
class LoadCities extends CitiesEvent {
  final String search;
  final int page;
  final int? countryId;
  final bool reset;

  LoadCities({
    this.search = '',
    this.page = 1,
    this.countryId = 0,
    this.reset = false,
  });
}
class ResetCity extends CitiesEvent {}

class StateLoading extends CitiesEvent {}

class DeleteClientEvent extends CitiesEvent { final String clientId; DeleteClientEvent(this.clientId); }
