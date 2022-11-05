import 'package:http/http.dart' as http;
import 'dart:convert';

class ConvertRepo {
  static final ConvertRepo _convertRepo = ConvertRepo._internal();

  factory ConvertRepo() {
    return _convertRepo;
  }
  ConvertRepo._internal();

  Future<double> convert(
      {required String fromCurr,
      required String toCurr,
      required double value}) async {
    final response = await http.get(Uri.parse(
        'https://v6.exchangerate-api.com/v6/5e8c375a23495c5883da2555/pair/${fromCurr}/${toCurr}/${value}'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final rate = jsonResponse['conversion_result'];
      return rate;
    } else {
      throw Exception('Failed to get data');
    }
  }
}
