import 'dart:convert';

import 'package:http/http.dart' as http;

class TransactionRepository {
  static const String baseUrl = 'http://skunkworks.ignitesol.com:8000/';

  Future<List<dynamic>> fetchTransactions({String? query}) async {
    final url = Uri.parse(
      baseUrl +
          'books?mime_type=image/jpeg&search=${Uri.encodeComponent(query ?? '')}',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'] as List<dynamic>;
    } else {
      throw Exception('Failed to fetch transactions');
    }
  }
}
