import '../../../Models/Supplier/SupplierModel.dart';

abstract class SuppliersEvent {}
class LoadSuppliers extends SuppliersEvent {
  final String search;
  final bool reset; // whether to reset the current list
  LoadSuppliers(this.search, {this.reset = false});
}
class SupplierLoading extends SuppliersEvent{}
class StoreSupplier extends SuppliersEvent {
  final Supplier supplier;
  StoreSupplier({required this.supplier});
}
class UpdateSupplier extends SuppliersEvent {
  final Supplier supplier;
  UpdateSupplier({required this.supplier});
}
class DeleteSupplier extends SuppliersEvent {
  final Supplier supplier;
  DeleteSupplier({required this.supplier});
}
class DeleteClientEvent extends SuppliersEvent { final String clientId; DeleteClientEvent(this.clientId); }
// ... similarly for UpdateClientEvent, etc.
