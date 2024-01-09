import 'package:bitcoin_ticker_flutter/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();

  PriceScreen(this.networkHelper);

  NetworkHelper networkHelper;
}

class _PriceScreenState extends State<PriceScreen> {
  //DEFAULT
  int exchangeRate = 0;
  String selectedCurrency = 'USD';

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Platform.isAndroid
        ? selectedCurrency = 'USD'
        : selectedCurrency = currenciesList[0];
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  //FUNCTIONS
  //ANDROID PICKER
  DropdownButton androidDropdownPicker() {
    List<DropdownMenuItem<String>> newDropdownMenu = [];
    for (String currency in currenciesList) {
      newDropdownMenu.add(DropdownMenuItem<String>(
        child: Text(currency),
        value: currency,
      ));
    }

    return DropdownButton(
        value: selectedCurrency,
        items: newDropdownMenu,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value!;
            exchangeRate = widget.networkHelper
                .getExchangeRateByCurrency(selectedCurrency);
          });
        });
  }

  //IOS PICKER
  CupertinoPicker iosDropdownPicker() {
    List<Text> dropdownItems = [];
    for (String currencies in currenciesList) {
      dropdownItems.add(Text(currencies));
    }

    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            selectedCurrency = dropdownItems[selectedIndex].data!;
            exchangeRate = widget.networkHelper
                .getExchangeRateByCurrency(selectedCurrency);
          });
        },
        children: dropdownItems.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text(
            'CryptoEx',
            style: TextStyle(letterSpacing: 2, fontSize: 26),
          )),
          automaticallyImplyLeading: false),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.white24,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${exchangeRate} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.white30,
            child: !Platform.isAndroid
                ? androidDropdownPicker()
                : iosDropdownPicker(),
          ),
        ],
      ),
      backgroundColor: Colors.black26,
    );
  }
}

/*
*/
