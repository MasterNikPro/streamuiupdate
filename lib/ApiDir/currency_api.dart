import 'dart:convert';

import 'package:http/http.dart' as http;

class CurrencyApi {
   static const _key = '4fe49fbf4baf5a7b866ecbbc5622f468';
  static Stream<double> getPrice() =>
      Stream.periodic(const Duration(seconds: 5)).asyncMap((_) => getPrices());

  static Future<double> getPrices() async {

    const url =
        'https://api.nomics.com/v1/currencies/ticker?key=$_key&ids=BTC&interval=1d';

    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body).first;
    final price = double.parse(body['price'].toString());
    return price;
  }
}
