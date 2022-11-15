import 'dart:convert';

import 'package:http/http.dart' as http;

class CurrencyApi {
  static Stream<double> getPrice() =>
      Stream.periodic(const Duration(seconds: 1)).asyncMap((_) => getPrices());

  static Future<double> getPrices() async {

    const url =
        'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    final price = double.parse(body['price'].toString());
    return price;
  }
}
