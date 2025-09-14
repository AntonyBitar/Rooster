import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../../Models/PaginationModels/PaginatedSupplier.dart';
import '../../../Models/Supplier/SupplierModel.dart';
import '../ApiProvider/SupplierApi.dart';

class SupplierRepository {
  final SupplierApi supplierApi;
  SupplierRepository(this.supplierApi);

  Future<PaginatedSuppliers> loadSuppliers(String search,int page)async {
    dynamic map= await supplierApi.fetchSuppliers(search,page);
    final suppliers = (map['data']['data'] as List)
        .map((j) => Supplier.fromJson(j as Map<String, dynamic>))
        .toList();
    final int lastPage = map['data']['last_page'] as int;
    final int currentPage = map['data']['current_page'] as int;
    final hasMore = currentPage < lastPage;
    return PaginatedSuppliers(suppliers: suppliers, hasMore: hasMore);

  }
  Future<http.Response> storeSupplier(Supplier supplierData)async {
    return await supplierApi.storeSupplier(supplierData);
  }
  Future<http.Response> updateSupplier(Supplier supplierData)async {
    return await supplierApi.updateSupplier(supplierData);

  }
  Future<http.Response> deleteSupplier(int supplierId)async {
    return await supplierApi.deleteSupplier(supplierId);
  }

  // Future<Map<String, List<TransactionModel>>> loadTransactions(String clientId, String search) {
  //   return supplierApi.fetchTransactions(clientId, search);
  // }
}
