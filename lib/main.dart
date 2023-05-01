import 'package:exchangeflutter/utils/service.dart';
import 'package:flutter/material.dart';
import 'package:exchangeflutter/model/exchange.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'EUR';
  String _toCurrency = 'USD';
  String _result = '';

  List<String> _currencyOptions = ['EUR', 'USD', 'GBP'];

  Future<void> _convert() async {
    String from = _fromCurrency;
    String to = _toCurrency;
    String amount = _amountController.text.trim();
    if (amount.isEmpty) {
      setState(() {
        _result = 'Please enter an amount';
      });
      return;
    }

    try {
      Exchange exchange = await Services.fetchProductData(to, from, amount);
      setState(() {
        _result = exchange.result.toString();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exchange Rate Converter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Exchange Rate Converter'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    hintText: 'Enter the amount to convert',
                  ),
                ),
                const SizedBox(height: 16.0),
                DropdownButton<String>(
                  value: _fromCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      _fromCurrency = newValue!;
                    });
                  },
                  hint: const Text('Select currency'),
                  items: _currencyOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16.0),
                DropdownButton<String>(
                  value: _toCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      _toCurrency = newValue!;
                    });
                  },
                  hint: const Text('Select currency'),
                  items: _currencyOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _convert,
                  child: const Text('Convert'),
                ),
                const SizedBox(height: 16.0),
                Text(_result),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
