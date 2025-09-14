import '../../../Models/Country/CountryModel.dart';

abstract class SuppliersCreationEvent {}
class LoadSupplierCreation extends SuppliersCreationEvent {
  final String search;
  final bool reset;
  final int page;
  final String? supplierCode;
  LoadSupplierCreation(this.search,this.page,{this.reset = false,this.supplierCode});
}
class LoadSupplierCreationLoading extends SuppliersCreationEvent {
  final bool reset;
  final String? search;

  LoadSupplierCreationLoading({this.reset = false, this.search});
}

class DeleteClientEvent extends SuppliersCreationEvent { final String clientId; DeleteClientEvent(this.clientId); }
// ... similarly for UpdateClientEvent, etc.
