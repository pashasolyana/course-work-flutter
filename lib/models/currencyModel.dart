import 'package:flutter/material.dart';

class Currency {
  Currency({required this.name, required this.price});

  late String name;
  late num price;

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(name: json[''], price: json['']);
  }
}

List<Currency> currencyList = [];
