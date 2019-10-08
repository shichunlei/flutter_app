import 'package:flutter/material.dart';

import 'data/crypto.dart';
import 'modules/crypto_list_presenter.dart';

class MvpHomePage extends StatefulWidget {
  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<MvpHomePage>
    implements CryptoListViewContract {
  CryptoListPresenter _presenter;
  List<Crypto> _currencies;
  bool _isLoading;

  _HomePageState() {
    _presenter = CryptoListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Crypto App")),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _currencies.length,
                itemBuilder: (BuildContext context, int index) =>
                    _getRowWithDivider(index),
              ));
  }

  Widget _getRowWithDivider(int i) {
    final Crypto currency = _currencies[i];
    var children = <Widget>[
      Padding(padding: EdgeInsets.all(10.0), child: _getListItemUi(currency)),
      Divider(height: 5.0),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  ListTile _getListItemUi(Crypto currency) {
    return ListTile(
      leading: FadeInImage(
          placeholder: NetworkImage(
              'https://github.com/iampawan/CryptoApp/blob/master/assets/stars.png?raw=true'),
          image: NetworkImage("http://cryptoicons.co/32@2x/color/" +
              currency.symbol.toLowerCase() +
              "@2x.png")),
      title: Text(currency.name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: _getSubtitleText(currency.priceUsd, currency.percentChange1h),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String priceUSD, String percentageChange) {
    TextSpan priceTextWidget =
        TextSpan(text: "\$$priceUSD\n", style: TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;

    if (double.parse(percentageChange) > 0) {
      percentageChangeTextWidget = TextSpan(
          text: percentageChangeText, style: TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidget = TextSpan(
          text: percentageChangeText, style: TextStyle(color: Colors.red));
    }

    return RichText(
        text:
            TextSpan(children: [priceTextWidget, percentageChangeTextWidget]));
  }

  @override
  void onLoadCryptoComplete(List<Crypto> items) {
    setState(() {
      _currencies = items;
      _isLoading = false;
    });
  }

  @override
  void onLoadCryptoError() {}
}
