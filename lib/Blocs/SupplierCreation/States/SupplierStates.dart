import 'package:rooster_app/Models/Supplier/SupplierModel.dart';

import '../../../Models/Country/CountryModel.dart';

abstract class SuppliersCreationState {}

  class SuppliersCreationInitial extends SuppliersCreationState {}



class SuppliersCreationLoadSuccess extends SuppliersCreationState {
  String _supplierCode;
  String _supplierCodeCopy;
  SuppliersCreationLoadSuccess({
    required String supplierCode,
    required String supplierCodeCopy,
  }) : _supplierCode = supplierCode,_supplierCodeCopy=supplierCodeCopy;

  // getter
  String get supplierCode => _supplierCode;
  String get supplierCodeCopy => _supplierCodeCopy;

  // setter
  set supplierCode(String value) {
    _supplierCode = value;
  }
}


class SuppliersCreationLoadFailure extends SuppliersCreationState {
  final String error;

  SuppliersCreationLoadFailure(this.error);
}
