import '../../../Models/PaginationModels/PaginatedSupplierCreation.dart';
import '../ApiProvider/SupplierApi.dart';

class SupplierCreationRepository {
  final SupplierCreationApi supplierApi;
  SupplierCreationRepository(this.supplierApi);

  Future<PaginatedSupplierCreation> loadSuppliersCreation()async {
      dynamic map= await supplierApi.fetchClients();
      return PaginatedSupplierCreation(supplierCode: map['data']['supplierCode'],);
  }
}
