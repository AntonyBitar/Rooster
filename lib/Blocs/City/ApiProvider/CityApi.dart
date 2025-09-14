import 'dart:convert';
import '../../../Locale_Memory/save_user_info_locally.dart';
import '../../../const/urls.dart';
import 'package:http/http.dart' as http;
class CityApi {
  final http.Client httpClient;
  CityApi(this.httpClient);

  Future<Map<String, dynamic>> fetchCities(String search,int page,countryId) async {
    final uri = Uri.parse(kCityUrl).replace(queryParameters: {
      'name': search,
      'isPaginated': '1',
      'page':page.toString(),
      'perPage':'15',
      'countryId':countryId.toString()
    });
    final token = await getAccessTokenFromPref();
    final response = await httpClient.get(uri, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to load suppliers');
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  // Future<Map<String, List<TransactionModel>>> fetchTransactions(String clientId, String search) async {
  //   final uri = Uri.parse('$kClientsTransactionsUrl/$clientId').replace(queryParameters: {
  //     'search': search, 'isPaginated': '0', 'cashCustomers': '1'
  //   });
  //   final token = await getAccessTokenFromPref();
  //   final response = await httpClient.get(uri, headers: {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token'
  //   });
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body)['data'];
  //     // parse orders and quotations into lists of models
  //     return {
  //       'orders': (data['orders'] as List).map((j) => TransactionOrder.fromJson(j)).toList(),
  //       'quotations': (data['quotations'] as List).map((j) => TransactionQuotation.fromJson(j)).toList(),
  //     };
  //   } else {
  //     throw Exception('Failed to load transactions');
  //   }
  // }
}
