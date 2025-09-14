import 'dart:convert';
import '../../../Locale_Memory/save_user_info_locally.dart';
import '../../../Models/Supplier/SupplierModel.dart';
import '../../../const/urls.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_connect/http/src/response/response.dart' as r;

class SupplierApi {
  final http.Client httpClient;
  SupplierApi(this.httpClient);

  Future<Map<String, dynamic>> fetchSuppliers(String search,int page) async {
    final uri = Uri.parse(kSupplierUrl).replace(queryParameters: {
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
      throw Exception(response.body);
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
  Future<http.Response> storeSupplier(Supplier supplierData) async {

    final uri = Uri.parse(kSupplierUrl);
    final token = await getAccessTokenFromPref();
    final response = await httpClient.post(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(supplierData.toJson()),
    );
    return response;
  }
  Future<http.Response> updateSupplier(Supplier supplierData) async {
    final uri = Uri.parse('$kSupplierUrl/${supplierData.id}');
    final token = await getAccessTokenFromPref();
    final response = await httpClient.put(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(supplierData.toJson()..remove('id')),
    );
    return response;
  }

  Future<http.Response> deleteSupplier(int supplierId) async {

    final token = await getAccessTokenFromPref();
    final uri = Uri.parse('$kSupplierUrl/$supplierId');
    final response = await httpClient.delete(uri, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
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
