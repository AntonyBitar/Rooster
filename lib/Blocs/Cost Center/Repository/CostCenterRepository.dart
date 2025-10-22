import 'package:rooster_app/Blocs/City/ApiProvider/CityApi.dart';
import 'package:rooster_app/Models/CostCenter/CostCenterModel.dart';
import '../../../Models/City/CityModel.dart';
import '../../../Models/PaginationModels/PaginatedCity.dart';
import '../../../Models/PaginationModels/PaginatedCostCenter.dart';
import '../ApiProvider/CostCenterApi.dart';
import 'package:http/http.dart' as http;

class CostCenterRepository {

  final CostCenterApi costCenterApi;
  CostCenterRepository(this.costCenterApi);

  Future<PaginatedCostCenter> loadCostCenters(String search,int page)async {
    dynamic map= await costCenterApi.fetchCostCenters(search,page);
    final costCenters = (map['data']['data'] as List)
        .map((j) => CostCenterModel.fromJson(j as Map<String, dynamic>))
        .toList();
    final int lastPage = map['data']['last_page'] as int;
    final int currentPage = map['data']['current_page'] as int;
    final hasMore = currentPage < lastPage;

    return PaginatedCostCenter(costCenters: costCenters, hasMore: hasMore);
  }
  Future<http.Response> storeCostCenter(List<CostCenterModel> costCenterData)async {
    return await costCenterApi.storeCostCenter(costCenterData);
  }
  Future<http.Response> updateCostCenter(CostCenterModel costCenterData)async {
    return await costCenterApi.updateCostCenter(costCenterData);

  }
  Future<http.Response> deleteCostCenter(int supplierId)async {
    return await costCenterApi.deleteCostCenter(supplierId);
  }
  // Future<Map<String, List<TransactionModel>>> loadTransactions(String clientId, String search) {
  //   return supplierApi.fetchTransactions(clientId, search);
  // }
}
