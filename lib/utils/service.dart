import 'dart:convert';
import 'package:exchangeflutter/model/exchange.dart';
import 'package:http/http.dart' as http;

class Services {
  static Future<Exchange> fetchProductData(
      String to, String from, String amount) async {
    final params = {
      "apikey": 'mbcw0nWGhs9Fxm7dvDWnzYhsbIFQUCHI',
      "to": to,
      "from": from,
      "amount": amount,
    };
    final uri =
        Uri.https("api.apilayer.com", "/exchangerates_data/convert", params);
    final response = await http.get(uri);
    print(response.body);

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final productList = Exchange.fromJson(decodedResponse);

      return productList;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
