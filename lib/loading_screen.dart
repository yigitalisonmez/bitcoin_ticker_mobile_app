import 'package:bitcoin_ticker_flutter/price_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'network_helper.dart';

final NetworkHelper networkHelper = NetworkHelper(
    'https://rest.coinapi.io/v1/exchangerate/BTC/apikey-23A294EF-CB49-4443-B5C7-14EAA28F6547/');

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    loadPriceScreen();
  }

  void loadPriceScreen() async {
    await networkHelper.fetchData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(networkHelper);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.grey,
          size: 50.0,
        ),
      ),
    );
  }
}
