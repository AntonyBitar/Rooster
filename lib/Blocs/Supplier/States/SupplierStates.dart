import 'package:rooster_app/Models/Supplier/SupplierModel.dart';

abstract class SuppliersState {}

class SuppliersInitial extends SuppliersState {}


class SuppliersLoadSuccess extends SuppliersState {
  final List<Supplier> suppliers;
  final bool hasReachedMax;

  SuppliersLoadSuccess({
    required this.suppliers,
    required this.hasReachedMax,
  });
}

class SuppliersLoadFailure extends SuppliersState {
  final String error;

  SuppliersLoadFailure(this.error);
}
class SuppliersStatus extends SuppliersState {
  final String message;
  final String title;
  final int statusCode;

  SuppliersStatus(this.message,this.title,this.statusCode);
}
