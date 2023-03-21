//TODOc: import here
import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

//TODO: create your getCoinData method here.

class CoinData {
  CoinData({required this.selectedCurrency});
  String selectedCurrency;

  static const apiKey = ' A90F5D7E-853E-4353-8506-DCD623B04E91';
  static const apiKey2 = ' D412658E-2B60-43E1-A245-2E350C4BD2DB';
  String url = 'https://rest.coinapi.io/v1/exchangerate/';

  Future<dynamic> getCoinData() async {
    List<double> allCoinData = [];

    for (int i = 0; i < cryptoList.length; i++) {
      String cryptoName = cryptoList[i];

      http.Response response = await http.get(
        Uri.parse('$url$cryptoName/$selectedCurrency?apikey=$apiKey2'),
      );
      if (response.statusCode == 200) {
        String decodeData = response.body;
        var coinData = jsonDecode(decodeData);
        double pricedData = coinData['rate'];
        //print(pricedData);
        allCoinData.add(pricedData);
      } else {
        print(response.statusCode);
        throw 'Problems with the get Request';
      }
    }
    return allCoinData;
  }
}
