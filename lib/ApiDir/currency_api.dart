import 'dart:convert';
import 'dart:js_util/js_util_wasm.dart';

import 'package:http/http.dart' as http;

class CurrencyApi {


  static Stream<double> getPrice() =>
      Stream.periodic(const Duration(seconds: 5)).asyncMap((_) => getPrices());
  static Future<double> getPrices() async {
    const url =
        'https://api.nomics.com/v1/currencies/ticker?key=your-key-here&ids=BTC,ETH,XRP&interval=1d,30d&convert=EUR&platform-currency=ETH&per-page=100&page=1';

    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body).first;
    final price = double.parse(body['price'].toString());
    return price;
  }
}
