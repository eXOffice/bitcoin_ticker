import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  //double bitCoinValueInUSD = 0.0;
  //CoinData coinData = CoinData(url: url);

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> item = [];
    // for (int i = 0; i < currenciesList.length; i++) {
    for (String currency in currenciesList) {
      //String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      item.add(newItem);
    }

    return DropdownButton<String>(
//isExpanded: true,
//itemHeight: null,
      value: selectedCurrency,
      icon: Icon(Icons.flutter_dash),
      iconEnabledColor: Colors.white,
      items: item,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getData(selectedCurrency);
//print(selectedCurrency);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> item = [];
    for (String currency in currenciesList) {
      item.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedValueChanged) {
        print(selectedValueChanged);
      },
      children: item,
    );
  }

  //TODO: create a method here called getData() to get the coin data from coin_data.dart.// DONE DONE
  String bitCoinValueInUSD = '?';
  String liteCoinValueInUSD = '?';
  String ethCoinValueInUSD = '?';
  void getData(String selectedCurrency) async {
    try {
      CoinData coinData = CoinData(selectedCurrency: selectedCurrency);
      List<double> allCoinData = await coinData.getCoinData();
      setState(() {
        bitCoinValueInUSD = allCoinData[0].toStringAsFixed(0);
        ethCoinValueInUSD = allCoinData[1].toStringAsFixed(0);
        liteCoinValueInUSD = allCoinData[2].toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    //TODO: Call getData when screen wake up / loads up, initial call. // DONE DONE
    super.initState();
    getData(selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      //TODO: update the Text Widget with the live bitcoin data here.
                      '1 BTC = $bitCoinValueInUSD $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      //TODO: update the Text Widget with the live bitcoin data here.
                      '1 ETH = $ethCoinValueInUSD $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      //TODO: update the Text Widget with the live bitcoin data here.
                      '1 LTC = $liteCoinValueInUSD $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}

//Version 3
// import 'dart:io' show Platform;
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'coin_data.dart';
// import 'network.dart';
//
// const apiKey = ' A90F5D7E-853E-4353-8506-DCD623B04E91';
//
// class PriceScreen extends StatefulWidget {
//   @override
//   _PriceScreenState createState() => _PriceScreenState();
// }
//
// class _PriceScreenState extends State<PriceScreen> {
//   String selectedCurrency = 'USD';
//   double? convertedValue;
//   var apiData;
//
//   Future<dynamic> getDataFromSelectedCurrency(String selectedCurrency) async {
//     //var url = 'https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=$apiKey';
//
//     NetworkHelper networkHelper = NetworkHelper(
//         url:
//             'https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=$apiKey');
//     var currencyData = await networkHelper.getData();
//     return currencyData;
//   }
//
//   void getCurrencyConvertedValue(apiData) {
//     convertedValue = apiData['rate'];
//     print(convertedValue);
//   }
//
//   DropdownButton<String> androidDropDown() {
//     List<DropdownMenuItem<String>> item = [];
//     // for (int i = 0; i < currenciesList.length; i++) {
//     for (String currency in currenciesList) {
//       //String currency = currenciesList[i];
//       var newItem = DropdownMenuItem(
//         child: Text(currency),
//         value: currency,
//       );
//       item.add(newItem);
//     }
//
//     return DropdownButton<String>(
// //isExpanded: true,
// //itemHeight: null,
//       value: selectedCurrency,
//       icon: Icon(Icons.flutter_dash),
//       iconEnabledColor: Colors.white,
//       items: item,
//       onChanged: (value) {
//         setState(() async {
//           selectedCurrency = value!;
//           apiData = await getDataFromSelectedCurrency(selectedCurrency);
//           print(apiData);
//           getCurrencyConvertedValue(apiData);
//         });
//
//         //getCurrencyConvertedValue();
//       },
//     );
//   }
//
//   CupertinoPicker iOSPicker() {
//     List<Widget> item = [];
//     for (String currency in currenciesList) {
//       item.add(Text(currency));
//     }
//
//     return CupertinoPicker(
//       itemExtent: 32.0,
//       onSelectedItemChanged: (selectedValueChanged) {
//         print(selectedValueChanged);
//       },
//       children: item,
//     );
//   }
//
//   Widget getPicker() {
//     if (Platform.isIOS) {
//       return iOSPicker();
//     } else if (Platform.isAndroid) {
//       return androidDropDown();
//     }
//     return Text('Its Null');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('🤑 Coin Ticker'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
//             child: Card(
//               color: Colors.lightBlueAccent,
//               elevation: 5.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
//                 child: Text(
//                   '1 BTC = $convertedValue $selectedCurrency',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             height: 150.0,
//             alignment: Alignment.center,
//             padding: EdgeInsets.only(bottom: 30.0),
//             color: Colors.lightBlue,
//             child:
//                 androidDropDown(), //Platform.isIOS ? iOSPicker() : androidDropDown(),
//           ),
//         ],
//       ),
//     );
//   }
// }

//======> version 1

// import 'dart:io' show Platform;
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'coin_data.dart';
//
// class PriceScreen extends StatefulWidget {
//   @override
//   _PriceScreenState createState() => _PriceScreenState();
// }
//
// class _PriceScreenState extends State<PriceScreen> {
//   String selectedCurrency = 'USD';
//
//   DropdownButton<String> androidDropDown() {
//     List<DropdownMenuItem<String>> item = [];
//     // for (int i = 0; i < currenciesList.length; i++) {
//     for (String currency in currenciesList) {
//       //String currency = currenciesList[i];
//       var newItem = DropdownMenuItem(
//         child: Text(currency),
//         value: currency,
//       );
//       item.add(newItem);
//     }
//
//     return DropdownButton<String>(
// //isExpanded: true,
// //itemHeight: null,
//       value: selectedCurrency,
//       icon: Icon(Icons.flutter_dash),
//       iconEnabledColor: Colors.white,
//       items: item,
//       onChanged: (value) {
//         setState(() {
//           selectedCurrency = value!;
// //print(selectedCurrency);
//         });
//       },
//     );
//   }
//
//   CupertinoPicker iOSPicker() {
//     List<Widget> item = [];
//     for (String currency in currenciesList) {
//       item.add(Text(currency));
//     }
//
//     return CupertinoPicker(
//       itemExtent: 32.0,
//       onSelectedItemChanged: (selectedValueChanged) {
//         print(selectedValueChanged);
//       },
//       children: item,
//     );
//   }
//
//   Widget getPicker() {
//     if (Platform.isIOS) {
//       return iOSPicker();
//     } else if (Platform.isAndroid) {
//       return androidDropDown();
//     }
//     return Text('Its Null');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('🤑 Coin Ticker'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
//             child: Card(
//               color: Colors.lightBlueAccent,
//               elevation: 5.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
//                 child: Text(
//                   '1 BTC = ? USD',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             height: 150.0,
//             alignment: Alignment.center,
//             padding: EdgeInsets.only(bottom: 30.0),
//             color: Colors.lightBlue,
//             child:
//                 androidDropDown(), //Platform.isIOS ? iOSPicker() : androidDropDown(),
//           ),
//         ],
//       ),
//     );
//   }
// }

int? a;

//Version 2

// import 'package:flutter/material.dart';
//
// import 'coin_data.dart';
// import 'network.dart';
//
// const apiKey = ' A90F5D7E-853E-4353-8506-DCD623B04E91';
//
// class PriceScreen extends StatefulWidget {
//   @override
//   _PriceScreenState createState() => _PriceScreenState();
// }
//
// String selectedCurrency = 'USD';
//
// class _PriceScreenState extends State<PriceScreen> {
//   var url =
//       'https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=$apiKey';
//   double convertedValue = 0.009;
//   var data;
//
//   void getApiData() async {
//     NetworkHelper networkHelper = NetworkHelper(url: url);
//     data = await networkHelper.getData();
//     //print(data);
//   }
//
//   void updateUI(dynamic data) {
//     setState(() {
//       if (data == null) {
//         convertedValue = 404.00;
//       }
//       print('its data data[rate] ummmm');
//       //print(data);
//       convertedValue = data['rate'];
//       print(convertedValue);
//     });
//   }
//
//   void convertedCurrencyValue() {}
//
//   List<DropdownMenuItem<String>> androidDropDown() {
//     List<DropdownMenuItem<String>> item = [];
//     // for (int i = 0; i < currenciesList.length; i++) {
//     for (String currency in currenciesList) {
//       //String currency = currenciesList[i];
//       var newItem = DropdownMenuItem(
//         child: Text(currency),
//         value: currency,
//       );
//       item.add(newItem);
//     }
//
//     return item;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('🤑 Coin Ticker'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
//             child: Card(
//               color: Colors.lightBlueAccent,
//               elevation: 5.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
//                 child: Text(
//                   '1 BTC = $convertedValue $selectedCurrency',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//               height: 150.0,
//               alignment: Alignment.center,
//               padding: EdgeInsets.only(bottom: 30.0),
//               color: Colors.lightBlue,
//               child: DropdownButton<String>(
// //isExpanded: true,
// //itemHeight: null,
//                 value: selectedCurrency,
//                 icon: Icon(Icons.flutter_dash),
//                 iconEnabledColor: Colors.white,
//                 items: androidDropDown(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedCurrency = value!;
//                     getApiData();
//                     updateUI(data);
//                   });
//                 },
//               )
//             //androidDropDown(), //Platform.isIOS ? iOSPicker() : androidDropDown(),
//           ),
//         ],
//       ),
//     );
//   }
// }
