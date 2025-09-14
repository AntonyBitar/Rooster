import 'package:rooster_app/Blocs/City/ApiProvider/CityApi.dart';
import '../../../Models/City/CityModel.dart';
import '../../../Models/PaginationModels/PaginatedCity.dart';

class CityRepository {
  final CityApi cityApi;
  CityRepository(this.cityApi);

  Future<PaginatedCities> loadCities(String search,int page,int countryId)async {
    dynamic map= await cityApi.fetchCities(search,page,countryId);
    final cities = (map['data']['data'] as List)
        .map((j) => City.fromJson(j as Map<String, dynamic>))
        .toList();
    final int lastPage = map['data']['last_page'] as int;
    final int currentPage = map['data']['current_page'] as int;
    final hasMore = currentPage < lastPage;
    return PaginatedCities(cities: cities, hasMore: hasMore);

  }

  // Future<Map<String, List<TransactionModel>>> loadTransactions(String clientId, String search) {
  //   return supplierApi.fetchTransactions(clientId, search);
  // }
}
