import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;
  var decodedData;
  bool flag = false;

  NetworkHelper(this.url);

  Future<void> fetchData() async {
    Uri address = Uri.parse(url);
    http.Response? response;
    try {
      response = await http.get(address);

      if (response.statusCode == 200) {
        var data = response.body;
        decodedData = jsonDecode(data);

        flag = true;
        print('Data fetching finished!');
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(response!.statusCode);
    }
  }

  int getExchangeRateByCurrency(String selectedCurrency) {
    print('Get Exchange triggered by $selectedCurrency');

    if (!flag) {
      fetchData();
    }

    for (var i = 0; i < decodedData['rates'].length; ++i) {
      if (selectedCurrency == decodedData['rates'][i]['asset_id_quote']) {
        return decodedData['rates'][i]['rate'].toInt();
      }
    }

    return -1;
  }
}
