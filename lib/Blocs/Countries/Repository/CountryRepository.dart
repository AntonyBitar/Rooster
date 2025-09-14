import '../../../Models/Country/CountryModel.dart';
import '../../../Models/PaginationModels/PaginatedCountry.dart';
import '../ApiProvider/CountryApi.dart';

class CountryRepository {
  final CountryApi countryApi;
  CountryRepository(this.countryApi);

  Future<PaginatedCountry> loadCountries(String search,int page)async {
    dynamic map= await countryApi.fetchClients(search,page);
      final countries = (map['data']['data'] as List)
          .map((j) => Country.fromJson(j as Map<String, dynamic>))
          .toList();
      final int lastPage = map['data']['last_page'] as int;
      final int currentPage = map['data']['current_page'] as int;
      final hasMore = currentPage < lastPage;
      return PaginatedCountry(countries: countries,
          hasMore: hasMore);
  }

  // Future<Map<String, List<TransactionModel>>> loadTransactions(String clientId, String search) {
  //   return supplierApi.fetchTransactions(clientId, search);
  // }
}
