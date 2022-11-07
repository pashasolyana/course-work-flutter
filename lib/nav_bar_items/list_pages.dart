import 'package:currency_picker/currency_picker.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/models/currencyCard.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/rates.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Map<dynamic, dynamic> rates;
  var keyIndices = [];
  var searchIndices = [];
  var choosenCurr = "USA";

  String _getImageName(String index) {
    return "assets/" + index + ".png";
  }

  dynamic fetchCoin() async {
    final response = await http.get(Uri.parse(
        'https://v6.exchangerate-api.com/v6/5e8c375a23495c5883da2555/latest/USD'));

    final map = json.decode(response.body);
    if (map["result"] == "success") {
      final ratesJSON = map["conversion_rates"];
      final ratesObject = new Rates.fromJson(ratesJSON);

      ratesObject.initValues();
      return ratesObject.rates;
    } else {
      throw Exception('FAILED');
    }
  }

  void _getRates() async {
    final response = await fetchCoin();
    if (response is Map) {
      for (var key in response.keys) {
        keyIndices.add(key);
      }
      setState(() {
        searchIndices = keyIndices;
        rates = response;
      });
    } else {
      throw Exception('FAILED N2');
    }
  }

  @override
  void initState() {
    fetchCoin();
    _getRates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey[100],
            title: Text('RATE LIST',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold))),
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: searchIndices.length,
            itemBuilder: (context, index) {
              final rate = rates[searchIndices[index]];
              return CurrencyCard(
                  name: searchIndices[index], price: rate["value"]);
            }));
  }
}
