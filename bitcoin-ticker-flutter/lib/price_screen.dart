import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  final coinData = CoinData();

  Map<String, String> prices = Map.fromIterable(
    cryptoList,
    key: (e) => e,
    value: (e) => '?',
  );

  int selectedCurrencyIndex = currenciesList.indexOf('USD') == -1
      ? 0
      : currenciesList.indexOf('USD');

  Future updatePricesForCurrency(String currency) async {
    try {
      final prices = await coinData.getPrices(currency);

      setState(() {
        this.prices = prices.map(
          (key, value) => MapEntry(key, value.toStringAsFixed(0)),
        );
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    updatePricesForCurrency(currenciesList[selectedCurrencyIndex]);
  }

  @override
  Widget build(BuildContext context) {
    final childrenList = prices.entries.map<Widget>((entry) {
      return Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${entry.key} = ${entry.value} ${currenciesList[selectedCurrencyIndex]}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: childrenList,
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CurrencyPicker(
              currencies: currenciesList,
              onChanged: (selectedIndex) async {
                await updatePricesForCurrency(currenciesList[selectedIndex]);

                setState(() {
                  selectedCurrencyIndex = selectedIndex;
                });
              },
              initialItem: selectedCurrencyIndex,
            ),
          ),
        ],
      ),
    );
  }
}

class CurrencyPicker extends StatelessWidget {
  final List<String> currencies;
  final Function(int) onChanged;
  final int initialItem;

  CurrencyPicker({
    @required this.currencies,
    @required this.onChanged,
    this.initialItem = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPicker(
        itemExtent: 32.0,
        backgroundColor: Colors.lightBlue,
        scrollController: FixedExtentScrollController(
          initialItem: initialItem,
        ),
        onSelectedItemChanged: onChanged,
        children: currenciesList.map((currency) {
          return Text(
            currency,
            style: TextStyle(
              color: Colors.white,
            ),
          );
        }).toList(),
      );
    } else {
      return DropdownButton<String>(
        value: currencies[initialItem],
        items: currenciesList.map((currency) {
          return DropdownMenuItem(
            child: Text(currency),
            value: currency,
          );
        }).toList(),
        onChanged: (newValue) {
          onChanged(currencies.indexOf(newValue));
        },
      );
    }
  }
}

