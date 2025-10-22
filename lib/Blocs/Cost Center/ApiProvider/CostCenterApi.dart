import 'dart:convert';
import 'package:rooster_app/Models/CostCenter/CostCenterModel.dart';

import '../../../Locale_Memory/save_user_info_locally.dart';
import '../../../const/urls.dart';
import 'package:http/http.dart' as http;
class CostCenterApi {
  final http.Client httpClient;
  CostCenterApi(this.httpClient);

  Future<Map<String, dynamic>> fetchCostCenters(String search,int page) async {
    final uri = Uri.parse(kCostCenterUrl).replace(queryParameters: {
      'name': search,
      'isPaginated': '1',
      'page':page.toString(),
      'perPage':'10',
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
  Future<http.Response> storeCostCenter(List<CostCenterModel> costCenterModel) async {

    final uri = Uri.parse(kCostCentersUrl);
    final token = await getAccessTokenFromPref();
    final response = await httpClient.post(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
        body: jsonEncode({
          'cost_centers': costCenterModel.map((e) => e.toJson()).toList()
        })
    );
    return response;
  }
  Future<http.Response> deleteCostCenter(int costCenterId) async {

    final token = await getAccessTokenFromPref();
    final uri = Uri.parse('$kCostCentersUrl/$costCenterId');
    final response = await httpClient.delete(uri, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    return response;
  }
  Future<http.Response> updateCostCenter(CostCenterModel costCenterData) async {
    final uri = Uri.parse('$kCostCentersUrl/${costCenterData.id}');
    final token = await getAccessTokenFromPref();
    final response = await httpClient.put(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
        body: jsonEncode(costCenterData.toJson())
    );
    return response;
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
